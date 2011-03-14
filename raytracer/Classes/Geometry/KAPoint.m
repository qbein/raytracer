//
//  Point.m
//  raytracer
//
//  Created by Kurt Aadnøy on 14.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import "KAPoint.h"


@implementation KAPoint

@synthesize x;
@synthesize y;
@synthesize z;

-(id)initWithX:(float)anX y:(float)aY andZ:(float)aZ {
    if(![super init]) return nil;
    
    self.x = anX;
    self.y = aY;
    self.z = aZ;
    
    return self;
}

-(void)dealloc {
    [super dealloc];
}

+(id)withX:(float)anX y:(float)aY andZ:(float)aZ {
    return [[[KAPoint alloc] initWithX:anX y:aY andZ:aZ] autorelease];
}

-(KAPoint*)addPoint:(KAPoint*)point {
    return [KAPoint withX:(point.x + self.x)
                      y:(point.y + self.y)
                   andZ:(point.z + self.z)];
}

@end
