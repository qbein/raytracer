//
//  Light.m
//  raytracer
//
//  Created by Kurt Aadnøy on 13.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import "Light.h"

@implementation Light

@synthesize positionX;
@synthesize positionY;
@synthesize positionZ;
@synthesize radius;
@synthesize color;

-(id)initWithX:(int)x y:(int)y z:(int)z radius:(int)r andColor:(NSColor*)c {
    if(![super init]) return nil;
    
    positionX = x;
    positionY = y;
    positionZ = z;
    radius = r;
    color = c;
    
    return self;
}

- (void)dealloc {
    [super dealloc];
    
    [color dealloc];
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@ x:%i y:%i z:%i r:%i color:%@", [self class], positionX, positionY, positionZ, radius, color];
}

@end
