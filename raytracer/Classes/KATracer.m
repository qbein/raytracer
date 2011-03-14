//
//  Tracer.m
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "KATracer.h"

@implementation KATracer

-(id)initWithWidth:(int)width
            height:(int)height
     andOutputFile:(NSString*)filename {
    if(![super init]) return nil;
    
    _width = width;
    _height = height;
    
    _filename = filename;
    [_filename retain];
    
    return self;
}

- (void)dealloc {
    [_filename release];
    [super dealloc];
}

-(void)renderScene:(KAScene*)scene {
    [scene retain];
    KAImage* image = [[KAImage alloc] initWithWidth:_width andHeight:_height];
    
    // TODO: Optimize with GCD block iterating?
    for(int y=0; y<_height; y++) {
        for(int x=0; x<_width; x++) {
            KARay* ray = [[KARay alloc] initWithOrigin:[KAPoint pointWithX:x y:y andZ:RAY_STARTING_POINT]
                                          andDirection:[KAVector vectorFromPoint:[KAPoint pointWithX:0 y:0 andZ:1.0f]]];
            
            float nearestIntersectDistance = RAY_MAX_LENGTH;
            id currentPrimitive = nil;
            
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
            
            // For simplicity we set the pixel color to the color of the
            // intersecting primitive
            [image setColor:[currentPrimitive color] AtX:x y:y];
            
            /*
            // TODO: add light to summarized color if in direct light
            for (Light* light in scene.lights) {
                
            }
            */
        }
    }
        
    [image writeImageToFile:_filename];
    
    [image release];
    [scene release];
}

@end

