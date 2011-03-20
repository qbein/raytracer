//
//  Vector.m
//  raytracer
//
//  Created by Kurt Aadnøy on 14.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import "KAVector3d.h"
#import "KAPoint3d.h"

@implementation KAVector3d

@synthesize x, y, z;

- (id)initWithX:(float)ax
              y:(float)ay
           andZ:(float)az {
    if(![super init]) return nil;
    
    self.x = ax;
    self.y = ay;
    self.z = az;
    
    return self;
}

+(id)vectorFromPoint:(KAPoint3d*)aPoint {
    return [[[KAVector3d alloc] initWithX:aPoint.x
                                        y:aPoint.y
                                     andZ:aPoint.z] autorelease];
}

+(id)vectorFromPoint:(KAPoint3d*)pointA
  substractedByPoint:(KAPoint3d*)pointB {
    return [[[KAVector3d alloc] initWithX:(pointA.x - pointB.x)
                                       y:(pointA.y - pointB.y)
                                    andZ:(pointA.z - pointB.z)] autorelease];
}

+(id)vectorFromPoint:(KAPoint3d*)pointA
        addedByPoint:(KAPoint3d*)pointB {
    return [[[KAVector3d alloc] initWithX:(pointA.x + pointB.x)
                                        y:(pointA.y + pointB.y)
                                     andZ:(pointA.z + pointB.z)] autorelease];
}

-(KAVector3d*)addVector:(KAVector3d*)aVector {
    KAVector3d* v = [self copy];
    
    v.x += aVector.x;
    v.y += aVector.y;
    v.z += aVector.z;
    
    return v;
}

-(KAVector3d*)substractVector:(KAVector3d*)aVector {
    KAVector3d* v = [self copy];
    
    v.x -= aVector.x;
    v.y -= aVector.y;
    v.z -= aVector.z;
    
    return v;
}

-(KAVector3d*)multiplyByVector:(KAVector3d*)aVector {
    KAVector3d* v = [self copy];
    
    v.x *= aVector.x;
    v.y *= aVector.y;
    v.z *= aVector.z;
    
    return v;
}

-(KAVector3d*)divideByVector:(KAVector3d*)aVector {
    KAVector3d* v = [self copy];
    
    v.x /= aVector.x;
    v.y /= aVector.y;
    v.z /= aVector.z;
    
    return v;
}

-(KAVector3d*)addFloat:(float)aFloat {
    KAVector3d* v = [self copy];
    
    v.x += aFloat;
    v.y += aFloat;
    v.z += aFloat;
    
    return v;
}

-(KAVector3d*)substractFloat:(float)aFloat {
    KAVector3d* v = [self copy];
    
    v.x -= aFloat;
    v.y -= aFloat;
    v.z -= aFloat;
    
    return v;
}

-(KAVector3d*)multiplyByFloat:(float)aFloat {
    KAVector3d* v = [self copy];
    
    v.x *= aFloat;
    v.y *= aFloat;
    v.z *= aFloat;
    
    return v;
}

-(KAVector3d*)divideByFloat:(float)aFloat {
    KAVector3d* v = [self copy];
    
    v.x /= aFloat;
    v.y /= aFloat;
    v.z /= aFloat;
    
    return v;
}

-(float)dot {
    return self.x + self.y + self.z;
}

-(float)length {
    return sqrt(self.x * self.x + self.y * self.y + self.z * self.z);
}

-(KAVector3d*)normalizedVector {
    KAVector3d* n = [self copy];
    
    return [n divideByFloat:[n length]];
}

-(NSString*)description {
    return [NSString stringWithFormat:@"<x:%f y:%f z:%f>", self.x, self.y, self.z];
}

-(KAVector3d*) copyWithZone:(NSZone *)zone {
    return [[[KAVector3d alloc] initWithX:self.x
                                        y:self.y
                                     andZ:self.z] autorelease];
}

@end
