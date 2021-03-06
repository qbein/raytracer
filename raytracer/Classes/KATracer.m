//
//  Tracer.m
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "KATracer.h"
#import "KARay.h"
#import "KAScene.h"
#import "KAImage.h"
#import "KALight.h"
#import "KAVector3d.h"
#import "KASphere.h"
#import "KAMaterial.h"

@implementation KATracer

@synthesize filename;

-(id)initWithOutputFile:(NSString*)aFilename {
    if(![super init]) return nil;
    
    self.filename = aFilename;
    
    return self;
}

- (void)dealloc {
    [filename release];
    [super dealloc];
}

-(void)renderScene:(KAScene*)scene {
    NSLog(@"Rendering image %@ @ %ix%i (scene version %@)", self.filename, scene.width, scene.height, scene.version);
    
    [scene retain];
    KAImage* image = [[KAImage alloc] initWithWidth:scene.width andHeight:scene.height];
    KARay* ray;
    
    NSDate* start = [NSDate date];
    
    // TODO: Optimize with GCD block iterating?
    for(int y=0; y<scene.height; y++) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        for(int x=0; x<scene.width; x++) {
            float red = 0, green = 0, blue = 0;
            float coef = 1.0f;
            int level = 0;
            
            // Calculate view directional vector
            KAPoint3d* rayStartPoint = [KAPoint3d pointWithX:scene.width / 2
                                                           y:scene.height / 2
                                                        andZ:RAY_STARTING_POINT * scene.zoom];
            
            KAPoint3d* rayScreenIntersectionPoint = [KAPoint3d pointWithX:x y:y andZ:0];
            
            KAVector3d* rayDirection = [[KAVector3d vectorFromPoint:rayScreenIntersectionPoint
                                                 substractedByPoint:rayStartPoint] normalizedVector];
            
            ray = [[KARay alloc] initWithOrigin:[KAPoint3d pointWithX:scene.width / 2 y:scene.height / 2 andZ:RAY_STARTING_POINT]
                                   andDirection:rayDirection];
            
            do {
                float nearestIntersectDistance = RAY_MAX_LENGTH;
                KASphere* currentPrimitive = nil;
                
                // Find the closest intersecting primitive
                for (id primitive in scene.primitives) {
                    float intersectDistance = [primitive findIntersectionForRay:ray
                                                                   withMaxDepth:nearestIntersectDistance];

                    if(intersectDistance < nearestIntersectDistance) {
                        nearestIntersectDistance = intersectDistance;
                        currentPrimitive = primitive;
                    }
                }
                
                // No intersecting primitive found, skip to next pixel
                if(!currentPrimitive) {
                    break;
                }
                
                // Calculate the intersection point on nearest sphere
                KAPoint3d* intersectionPoint = [ray.origin addVector:[ray.direction multiplyByFloat:nearestIntersectDistance]];
                
                // Find the normal vector between sphere center and intersection
                KAVector3d* normalVector = [[KAVector3d vectorFromPoint:intersectionPoint
                                                     substractedByPoint:currentPrimitive.position] normalizedVector];
                
                for (KALight* light in scene.lights) {
                    KAVector3d* intersectionToLightVector = [KAVector3d vectorFromPoint:light.position
                                                                     substractedByPoint:intersectionPoint];
                    [intersectionToLightVector retain];
                    
                    // If the lightsource is in shadow behind the sphere, continue
                    if([[intersectionToLightVector multiplyByVector:normalVector] dot] <= 0.0f) {
                        [intersectionToLightVector release];
                        continue;
                    }
                    
                    if([intersectionToLightVector length] <= 0.0f) {
                        [intersectionToLightVector release];
                        continue;
                    }
                    
                    KARay* lightRay = [[KARay alloc] initWithOrigin:intersectionPoint
                                                       andDirection:[intersectionToLightVector multiplyByFloat:(1/[intersectionToLightVector length])]];
                    
                    BOOL inShadow = NO; 
                    for(KASphere* sphere in scene.primitives) {
                        float shadowIntersectionPoint = [sphere findIntersectionForRay:lightRay
                                                                          withMaxDepth:[intersectionToLightVector length]];
                        
                        if(shadowIntersectionPoint < [intersectionToLightVector length]) {
                            inShadow = YES;
                            break;
                        }
                    }
                    
                    if(!inShadow) {
                        // Lambert
                        float lambert = [[lightRay.direction multiplyByVector:normalVector] dot] * coef;
                        
                        if(lambert < 0) {
                            lambert *= -1;
                        }
                         
                        red += lambert * [light.color redComponent] * [currentPrimitive.material.color redComponent];
                        green += lambert * [light.color greenComponent] * [currentPrimitive.material.color greenComponent];
                        blue += lambert * [light.color blueComponent] * [currentPrimitive.material.color blueComponent];
                        
                        // Blinn-Phong
                        KAVector3d* blinnDirection = [lightRay.direction substractVector:ray.direction];
                        float temperature = [blinnDirection length];
                        if(temperature != 0.0f) {
                            blinnDirection = [blinnDirection multiplyByFloat:(1.0f / temperature)];
                            float blinnTerm = fmax([[blinnDirection multiplyByVector:normalVector] dot], 0.0f);
                            blinnTerm = powf(blinnTerm, currentPrimitive.material.specularPower) * coef;
                            
                            red += blinnTerm * currentPrimitive.material.specular * [light.color brightnessComponent];
                            green += blinnTerm * currentPrimitive.material.specular * [light.color brightnessComponent];
                            blue += blinnTerm * currentPrimitive.material.specular * [light.color brightnessComponent];
                        }
                    }
                    
                    [intersectionToLightVector release];
                    [lightRay release];
                }
                
                // We iterate on the next reflection
                coef *= currentPrimitive.material.reflection;                
                
                KARay* bouncedRay = [ray rayBouncedOfSphereAt:intersectionPoint 
                                            usingNormalVector:normalVector];
                
                [ray release];
                ray = bouncedRay;
                [ray retain];
                
                level++;
            } while ((coef > 0.0f) && (level < 10));
            
            if(ray) [ray release];
            
            [image setColor:[NSColor colorWithDeviceRed:red green:green blue:blue alpha:1.0f] AtX:x y:y];
        }
        
        [pool release];
    }
     
    NSTimeInterval renderTime = [[NSDate date] timeIntervalSinceDate:start];
    NSLog(@"Rendered scene in %f seconds", renderTime);
    
    // Output jpeg image if jpg output file is specified, default to tiff if not
    if([self.filename rangeOfString:@".jpg"].length > 0) {
        NSLog(@"Written image as jpg");
        [image writeJpegImageToFile:self.filename];
    } else {
        NSLog(@"Written image as tiff");
        [image writeTiffImageToFile:self.filename];
    }
    
    [image release];
    [scene release];
}

@end

