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

-(void)renderScene:(Scene*)scene {
    [scene retain];
    Image* image = [[Image alloc] initWithWidth:_width andHeight:_height];
    
    // TODO: Optimize with GCD block iterating?
    for(int y=0; y<_height; y++) {
        for(int x=0; x<_width; x++) {
            Ray* ray = [[Ray alloc] initWithX:x y:y andMaxLength:MAX_DEPTH];
            
            // TODO: for each object in scene find any intersections with ray
            for (Primitive* primitive in scene.primitives) {
                if([primitive intersectsRay:ray]) {
                    // TODO: get intersection point
                    for (Light* light in scene.lights) {
                        // TODO: add light to summarized color if in direct light
                    }
                }
            }
        }
    }
        
    [image writeImageToFile:_filename];
    
    [image release];
    [scene release];
}

- (void)dealloc {
    [_filename release];
    [super dealloc];
}

@end

