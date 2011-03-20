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
#import "KAPrimitive.h"
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
    
    // TODO: Optimize with GCD block iterating?
    for(int y=0; y<scene.height; y++) {
        for(int x=0; x<scene.width; x++) {
            float red = 0, green = 0, blue = 0;
            float coef = 1.0f;
            int level = 0;
            
            for (KALight* light in scene.lights) {
                if(light.position.x == x && light.position.y == y) {
                    NSLog(@"print light");
                    red = 1.0f;
                    green = 1.0f;
                    blue = 1.0f;
                }
            }
            
            //if(x == 270 && y == 130) { [image setColor:[NSColor colorWithDeviceRed:1.0f green:1.0f blue:1.0f alpha:0.0f] AtX:x y:y]; continue; }
            
            KARay* ray = [[KARay alloc] initWithOrigin:[KAPoint3d pointWithX:x y:y andZ:RAY_STARTING_POINT]
                                          andDirection:[KAVector3d vectorFromPoint:[KAPoint3d pointWithX:0 y:0 andZ:1.0f]]];
            
            do {
                float nearestIntersectDistance = RAY_MAX_LENGTH;
                KASphere* currentPrimitive = nil;
                
                // Find the closest intersecting primitive
                for (id primitive in scene.primitives) {
                    float intersectDistance = [primitive findIntersectionsForRay:ray
                                                                    withMaxDepth:nearestIntersectDistance];
                    
                    if(intersectDistance < nearestIntersectDistance) {
                        nearestIntersectDistance = intersectDistance;
                        currentPrimitive = primitive;
                    }
                }
                
                if(x == 270 && y == 130) {
                    NSLog(@"intersection: %f", nearestIntersectDistance);
                }
                
                // No intersecting primitive found, skip to next pixel
                if(!currentPrimitive) {
                    break;
                }
                
                // Calculate the intersection point on nearest sphere
                KAPoint3d* sphereIntersectionPoint = [ray.origin addVector:[ray.direction multiplyByFloat:nearestIntersectDistance]];
                
                // Find the normal vector between sphere center and intersection
                KAVector3d* normalVector = [[KAVector3d vectorFromPoint:sphereIntersectionPoint
                                                     substractedByPoint:currentPrimitive.position] normalizedVector];
                
                for (KALight* light in scene.lights) {
                    // See if sphere intersection is facing the light, continue it not
                    KAVector3d* intersectionToLightVector = [KAVector3d vectorFromPoint:light.position
                                                                       substractedByPoint:sphereIntersectionPoint];
                    
                    if(x == 65 && y == 50) {
                        red = 1.0f;
                        green = 1.0f;
                        blue = 1.0f;
                        NSLog(@"ray %@", ray);
                        NSLog(@"sphereIntersection %@", sphereIntersectionPoint);
                        NSLog(@"intersectionToLightVector: %@", intersectionToLightVector);
                        NSLog(@"normal: %@", normalVector);
                        NSLog(@"intersect * normal dot: %f", [[intersectionToLightVector multiplyByVector:normalVector] dot]);
                    }
                    // If the lightsource is not in sigt, continue to next light
                    if([[intersectionToLightVector multiplyByVector:normalVector] dot] <= 0.0f) {
                        continue;
                    }
                    
                    if(x == 50 && y == 50) {
                        NSLog(@"%@", intersectionToLightVector);
                        NSLog(@"%f", [intersectionToLightVector dot]);
                        NSLog(@"intsect^2: %f", [[intersectionToLightVector multiplyByVector:intersectionToLightVector] dot]);
                        NSLog(@"intsect^2 sqrt: %f", sqrtf([[intersectionToLightVector multiplyByVector:intersectionToLightVector] dot]));
                    }
                    
                    if(sqrtf([[intersectionToLightVector multiplyByVector:intersectionToLightVector] dot]) <= 0.0f) {
                        continue;
                    }
                    
                    bool inShadow = false; 
                    for(KASphere* sphere in scene.primitives) {
                        if([sphere findIntersectionsForRay:ray withMaxDepth:[intersectionToLightVector dot]] < [intersectionToLightVector dot]) {
                            inShadow = true;
                            break;
                        }
                    }
                    if (!inShadow) {
                        float lambert = [[ray.direction multiplyByVector:normalVector] dot] * coef;
                        
                        if(lambert < 0) {
                            lambert *= -1;
                        }
                        
                        red += lambert * [light.color redComponent] * [currentPrimitive.material.color redComponent];
                        green += lambert * [light.color greenComponent] * [currentPrimitive.material.color greenComponent];
                        blue += lambert * [light.color blueComponent] * [currentPrimitive.material.color blueComponent];
                    }
                }
                
                // We iterate on the next reflection
                coef *= currentPrimitive.material.reflection;
                float reflet = [[[ray.direction multiplyByVector:normalVector] multiplyByFloat:2.0f] dot];
                ray.origin = sphereIntersectionPoint;
                
                ray.direction = [ray.direction substractFloat:[[normalVector multiplyByFloat:reflet] dot]];
                level++;
                
            } while (coef > 0.0f && level < 2);
            
            [image setColor:[NSColor colorWithDeviceRed:red green:green blue:blue alpha:1.0f] AtX:x y:y];
        }
    }
        
    [image writeImageToFile:self.filename];
    
    [image release];
    [scene release];
}

@end

