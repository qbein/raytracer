//
//  Image.m
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "KAImage.h"


@implementation KAImage

-(id)initWithWidth:(NSInteger)width
         andHeight:(NSInteger)height {
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

-(void)dealloc {
    [pixels release];
    [imageRep release];
    [super dealloc];
}

-(void)setColor:(NSColor*)color
            AtX:(NSInteger)x
              y:(NSInteger)y {  
    [imageRep setColor:color atX:x y:y];
}

-(void)writeImageToFile:(NSString*)fileName {
	[[imageRep TIFFRepresentation] writeToFile:fileName atomically:YES];
}

@end
