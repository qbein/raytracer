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

@interface Tracer : NSObject {
    int _width;
    int _height;    
    Scene* _scene;
    Image* _image;
}

-(id)initWithWidth:(int)width
         andHeight:(int)height;

-(void)renderScene:(Scene*)scene;

@end

