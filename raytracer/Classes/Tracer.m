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
        float intensity = ((float) y+1) / _height;
        
        for(int x=0; x<_width; x++) {
            // TODO: remove test output
            [image setColor:[NSColor colorWithDeviceRed:intensity green:0.0 blue:intensity alpha:1.0] AtX:x y:y];
            
            Ray* ray = [[Ray alloc] initWithX:x y:y andMaxLength:MAX_DEPTH];
            
            // TODO: for each object in scene find any intersections with ray
            // TODO: for each intersection:
            // TODO: for each light in scene:
            // TODO: if light is not in shadow, add light to summarized color
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

