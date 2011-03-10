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
         andHeight:(int)height {
    if(![super init]) return nil;
    
    _width = width;
    _height = height;
    
    _image = [[Image alloc] initWithWidth:_width andHeight:_height];
    
    return self;
}

-(void)renderScene:(Scene*)scene {
    _scene = scene;
        
    for(NSInteger x=0; x<_width; x++) {
        for(NSInteger y=0; y<_height; y++) {
            [_image setColor:[NSColor colorWithDeviceRed:1.0 green:0.0 blue:0.0 alpha:1.0] AtX:x y:y];
        }
    }
    
    [_image writeImageToFile:@"/Users/kurt/Desktop/test.tiff"];
}

- (void)dealloc {
    [_image release];
    _image = nil;
    
    [_scene release];
    _scene = nil;
    
    [super dealloc];
}

@end

