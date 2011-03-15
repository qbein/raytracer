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
#import "KAVector.h"
#import "KASphere.h"

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
            BOOL colorSet = NO;
            for (KALight* light in scene.lights) {
                if(((int)light.position.x == x) && ((int) light.position.y == y)) {
                    NSLog(@"Indicating a light at %@", light.position);
                    [image setColor:NSColor.whiteColor AtX:x y:y];
                    colorSet = YES;
                }
            }
            
            if(colorSet) continue;
            
            KARay* ray = [[KARay alloc] initWithOrigin:[KAPoint pointWithX:x y:y andZ:RAY_STARTING_POINT]
                                          andDirection:[KAVector vectorFromPoint:[KAPoint pointWithX:0 y:0 andZ:1.0f]]];
            
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
            
            // No intersecting primitive found, skip to next pixel
            if(!currentPrimitive) {
                [image setColor:[NSColor colorWithRGBString:@"0,0,0"] AtX:x y:y];
                continue;
            }
            
            // Calculate the intersection point on nearest sphere
            KAPoint* sphereIntersectionPoint = [ray.origin addVector:[ray.direction multiplyWithFloat:nearestIntersectDistance]];
            // Find the normal vector between sphere center and intersection
            KAVector* normalVector = [KAVector vectorFromPoint:sphereIntersectionPoint substractedBy:currentPrimitive.position];
                        
            // TODO: Need to figure out in which cases this is true
            // TODO: And what is the normalized vector?
            double tmp = [[normalVector multiplyWith:normalVector] summarize];
            if(tmp == 0.0f) {
                continue;
            }
            
            // TODO: guessing that we're finding what side of the sphere we're at, true?
            tmp = 1.0f / sqrtf(tmp); 
            normalVector = [normalVector multiplyWithFloat:tmp];
            
            // TODO: add light to summarized color if in direct light
            for (KALight* light in scene.lights) {
                
                // See if sphere intersection is facing the light, continue it not
                KAVector* intersectionToLightDistance = [KAVector vectorFromPoint:sphereIntersectionPoint substractedBy:light.position];
                if([[intersectionToLightDistance multiplyWith:normalVector] summarize] <= 0.0f) {
                    continue;
                }
                
                if([intersectionToLightDistance summarize] <= 0.0f) {
                    continue;
                }
                
                // TODO: The highlights are set inverted, e.g. we draw the areas that is in shadow, not in direct light - is the normalizing inverted somewhere?
                [image setColor:light.color AtX:x y:y];
            }
        }
    }
        
    [image writeImageToFile:self.filename];
    
    [image release];
    [scene release];
}

@end

