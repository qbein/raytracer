//
//  Point.m
//  raytracer
//
//  Created by Kurt Aadnøy on 14.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import "KAPoint3d.h"
#import "KAVector3d.h"

@implementation KAPoint3d

@synthesize x, y, z;

-(id)initWithX:(float)ax y:(float)ay andZ:(float)az {
    if(![super init]) return nil;
    
    self.x = ax;
    self.y = ay;
    self.z = az;
    
    return self;
}

+(id)pointWithX:(float)anX
              y:(float)aY
           andZ:(float)aZ {
    return [[[KAPoint3d alloc] initWithX:anX
                                       y:aY
                                    andZ:aZ] autorelease];
}

-(KAPoint3d*)addPoint:(KAPoint3d*)point {
    return [KAPoint3d pointWithX:(point.x + self.x)
                      y:(point.y + self.y)
                   andZ:(point.z + self.z)];
}

-(KAPoint3d*)addVector:(KAVector3d*)aVector {
    return [KAPoint3d pointWithX:(self.x + aVector.x)
                             y:(self.y + aVector.y)
                          andZ:(self.z + aVector.z)];
}

-(NSString*)description {
    return [NSString stringWithFormat:@"<x:%f y:%f z:%f>", self.x, self.y, self.z];
}

-(KAPoint3d*) copyWithZone:(NSZone *)zone {
    return [[[KAPoint3d alloc] initWithX:self.x
                                        y:self.y
                                     andZ:self.z] autorelease];
}
    
@end
