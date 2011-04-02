//
//  Image.h
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface KAImage : NSObject {
    int _width, _height;
    NSBitmapImageRep* imageRep;
    NSData* pixels;
}

-(id)initWithWidth:(NSInteger)width
         andHeight:(NSInteger)height;

-(void)setColor:(NSColor*)color
            AtX:(NSInteger)x
              y:(NSInteger)y;

-(void)writeTiffImageToFile:(NSString*)fileName;

-(void)writeJpegImageToFile:(NSString*)filename;

@end
