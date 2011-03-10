//
//  Image.m
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "Image.h"


@implementation Image

-(id)initWithWidth:(int)width andHeight:(int)height {
    if(![super init]) return nil;
    
    imageRep = [[NSBitmapImageRep alloc]
                initWithBitmapDataPlanes:NULL
                pixelsWide:width
                pixelsHigh:height
                bitsPerSample:8
                samplesPerPixel:4
                hasAlpha:YES
                isPlanar:NO
                colorSpaceName:NSDeviceRGBColorSpace
                bytesPerRow:(4 * width)
                bitsPerPixel:32];
    
    return self;
}

-(void)setColor:(NSColor*)color
            AtX:(NSInteger)x
              y:(NSInteger)y {  
    [imageRep setColor:color atX:x y:y];
}

-(void)writeImageToFile:(NSString*)fileName {
	[[imageRep TIFFRepresentation] writeToFile:fileName atomically:YES];
}

- (void)dealloc {
    [pixels release];
    pixels = nil;
    
    [imageRep release];
    imageRep = nil;
    
    [super dealloc];
}

@end
