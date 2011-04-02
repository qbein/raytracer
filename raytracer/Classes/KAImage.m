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

-(void)writeTiffImageToFile:(NSString*)fileName {
	[[imageRep TIFFRepresentation] writeToFile:fileName atomically:YES];
}

-(void)writeJpegImageToFile:(NSString*)filename {
    NSNumber* compressionFactor = [NSNumber numberWithFloat:0.8];
    NSDictionary* imageProperties = [NSDictionary dictionaryWithObject:compressionFactor
                                                                forKey:NSImageCompressionFactor];
    NSData* bitmapData = [imageRep representationUsingType:NSJPEGFileType
                                                properties:imageProperties];
    
    [bitmapData writeToFile:filename atomically:YES];
}

@end
