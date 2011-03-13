//
//  Ray.m
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "Ray.h"


@implementation Ray

@synthesize originX;
@synthesize originY;
@synthesize length;

-(id)initWithX:(int)x y:(int)y andMaxLength:(int)l {
    if(![super init]) return nil;
    
    originX = x;
    originY = y;
    length = l;
    
    return self;
}

@end
