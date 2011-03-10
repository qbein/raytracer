//
//  Image.h
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface Image : NSObject {
    int _width;
    int _height;
    NSBitmapImageRep* imageRep;
    NSData* pixels;
}

-(id)initWithWidth:(int)width
         andHeight:(int)height;

-(void)setColor:(NSColor*)color
            AtX:(NSInteger)x
              y:(NSInteger)y;

-(void)writeImageToFile:(NSString*)fileName;

@end
