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

- (id)initWithX:(float)x
              y:(float)y
              z:(float)z
         radius:(float)r
       andColor:(NSColor*)c {
    if(![super init]) return nil;
    
    self.positionX = x;
    self.positionY = y;
    self.positionZ = z;
    self.radius = r;
    self.color = c;
    
    return self;
}

- (void)dealloc {
    [color dealloc];
    [super dealloc];
}

-(float)findIntersectionsForRay:(Ray *)ray {
    if(ray.originX <= (self.positionX + self.radius) && ray.originX >= (self.positionX - self.radius)) {
        if(ray.originY <= (self.positionY + self.radius) && ray.originY >= (self.positionY - self.radius)) return 0;
    }
    
    return 9999999;
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@ x:%f y:%f z:%f r:%f color:%@", [self class], self.positionX, self.positionY, self.positionZ, self.radius, self.color];
}

@end
