//
//  Sphere.m
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "KASphere.h"


@implementation KASphere

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

-(float)findIntersectionsForRay:(KARay *)ray {
    // vecteur dist = s.pos - r.start; 
    KAVector* vector = [ray vectorRepresentation]; 
    // self.positionZ - ray.startZ;
    
    // double B = r.dir * dist;
    // double D = B*B - dist * dist + s.size * s.size; 
    // if (D < 0.0f) 
    //     return false; 
    // double t0 = B - sqrt(D); 
    // double t1 = B + sqrt(D);
    // bool retvalue = false;  
    // if ((t0 > 0.1f) && (t0 < t)) 
    // {
    //     t = (float)t0;
    //     retvalue = true; 
    // } 
    // if ((t1 > 0.1f) && (t1 < t)) 
    // {
    //     t = (float)t1; 
    //     retvalue = true; 
    // }
    
    return -1.0f;
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@ x:%f y:%f z:%f r:%f color:%@", [self class], self.positionX, self.positionY, self.positionZ, self.radius, self.color];
}

@end
