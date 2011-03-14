//
//  Sphere.h
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "KAPrimitive.h"

@interface KASphere : KAPrimitive

@property float positionX;
@property float positionY;
@property float positionZ;
@property float radius;
@property (retain) NSColor* color;

- (id)initWithX:(float)x
              y:(float)y
              z:(float)z
         radius:(float)r
       andColor:(NSColor*)c;

@end
