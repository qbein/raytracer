//
//  Ray.m
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "Ray.h"


@implementation Ray

-(id)initWithX:(int)x y:(int)y z:(int)z andDepth:(int)length {
    if(![super init]) return nil;
    
    _x = x;
    _y = y;
    _z = z;
    _length = length;
    
    return self;
}

@end
