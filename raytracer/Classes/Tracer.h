//
//  Tracer.h
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#import "Scene.h"
#import "Image.h"

#define MAX_DEPTH 1000

@interface Tracer : NSObject {
    int _width, _height;    
    NSString* _filename;
    Scene* _scene;
    Image* _image;
}

-(id)initWithWidth:(int)width
            height:(int)height
     andOutputFile:(NSString*)filename;

-(void)renderScene:(Scene*)scene;

@end

