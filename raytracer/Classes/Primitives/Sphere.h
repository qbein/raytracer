//
//  Sphere.h
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "Primitive.h"

@interface Sphere : Primitive {
}

@property int positionX;
@property int positionY;
@property int positionZ;
@property int radius;
@property (retain) NSColor* color;

- (id)initWithX:(int)x y:(int)y z:(int)z radius:(int)r andColor:(NSColor*)c;

@end
