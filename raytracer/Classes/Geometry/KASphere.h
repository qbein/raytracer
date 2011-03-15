//
//  Sphere.h
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "KAPrimitive.h"

@class KAPoint;

@interface KASphere : KAPrimitive

@property (retain) KAPoint* position;
@property float radius;
@property (retain) NSColor* color;

-(id)initWithPosition:(KAPoint*)aPosition
         radius:(float)aRadius
       andColor:(NSColor*)aColor;

@end
