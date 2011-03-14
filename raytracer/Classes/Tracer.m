//
//  Tracer.m
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "Tracer.h"

@implementation Tracer

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

-(void)renderScene:(Scene*)scene {
    [scene retain];
    Image* image = [[Image alloc] initWithWidth:_width andHeight:_height];
    
    // TODO: Optimize with GCD block iterating?
    for(int y=0; y<_height; y++) {
        for(int x=0; x<_width; x++) {
            Ray* ray = [[Ray alloc] initWithX:x y:y andZ:RAY_STARTING_POINT];
            float nearestIntersectDistance = RAY_MAX_LENGTH;
            
            for (id primitive in scene.primitives) {
                float intersectDistance = [primitive findIntersectionsForRay:ray];
                
                if(intersectDistance < nearestIntersectDistance) {
                    nearestIntersectDistance = intersectDistance;
                    
                    [image setColor:[primitive color] AtX:x y:y];
                    /*
                    for (Light* light in scene.lights) {
                        // TODO: add light to summarized color if in direct light
                    }
                    */
                }
                // No intersections, render default color
                else {
                    [image setColor:[NSColor colorWithRGBString:@"0,0,0"] AtX:x y:y];
                }
            }
        }
    }
        
    [image writeImageToFile:_filename];
    
    [image release];
    [scene release];
}

@end

