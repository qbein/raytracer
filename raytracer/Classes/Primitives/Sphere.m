//
//  Sphere.m
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "Sphere.h"


@implementation Sphere

@synthesize positionX;
@synthesize positionY;
@synthesize positionZ;
@synthesize radius;
@synthesize color;

- (id)initWithX:(int)x y:(int)y z:(int)z radius:(int)r andColor:(NSColor*)c {
    if(![super init]) return nil;
    
    self.positionX = x;
    self.positionY = y;
    self.positionZ = z;
    self.radius = r;
    self.color = c;
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@ x:%i y:%i z:%i r:%i color:%@", [self class], self.positionX, self.positionY, self.positionZ, self.radius, self.color];
}

@end
