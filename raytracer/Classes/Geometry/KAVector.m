//
//  Vector.m
//  raytracer
//
//  Created by Kurt Aadnøy on 14.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import "KAVector.h"
#import "KAPoint.h"

@implementation KAVector

@synthesize x;
@synthesize y;
@synthesize z;

- (id)initWithX:(float)anX y:(float)aY andZ:(float)aZ {
    if(![super init]) return nil;
    
    self.x = anX;
    self.y = aY;
    self.z = aZ;
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

+(id)vectorFromPoint:(KAPoint*)aPoint; {
    return [[[KAVector alloc] initWithX:aPoint.x y:aPoint.y andZ:aPoint.z] autorelease];
}

+(id)vectorFromPoint:(KAPoint*)pointA
       substractedBy:(KAPoint*)pointB {
    return [[[KAVector alloc] initWithX:(pointA.x - pointB.x)
                                     y:(pointA.y - pointB.y)
                                   andZ:(pointA.z - pointB.z)] autorelease];
}

+(id)vectorFromPoint:(KAPoint*)pointA
             addedBy:(KAPoint*)pointB {
    return [[[KAVector alloc] initWithX:(pointA.x + pointB.x)
                                      y:(pointA.y + pointB.y)
                                   andZ:(pointA.z + pointB.z)] autorelease];
}

-(KAVector*)add:(KAVector*)aVector {
    return [KAVector vectorFromPoint:[KAPoint pointWithX:(self.x + aVector.x)
                                                       y:(self.y + aVector.y)
                                                    andZ:(self.z + aVector.z)]];
}

-(KAVector*)addWithPoint:(KAPoint*)aPoint {
    return [KAVector vectorFromPoint:[KAPoint pointWithX:(self.x + aPoint.x)
                                                       y:(self.y + aPoint.y)
                                                    andZ:(self.z + aPoint.z)]];
}

-(KAVector*)multiplyWith:(KAVector*)aVector {
    return [KAVector vectorFromPoint:[KAPoint pointWithX:(self.x * aVector.x)
                                                       y:(self.y * aVector.y)
                                                    andZ:(self.z * aVector.z)]];
}

-(KAVector*)multiplyWithFloat:(float)aFloat {
    return [KAVector vectorFromPoint:[KAPoint pointWithX:(self.x * aFloat)
                                                       y:(self.y * aFloat)
                                                    andZ:(self.z * aFloat)]];
}

-(float)summarize {
    return self.x + self.y + self.z;
}

-(NSString*)description {
    return [NSString stringWithFormat:@"x:%f y:%f z:%f", self.x, self.y, self.z];
}

@end
