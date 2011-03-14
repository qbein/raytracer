//
//  Vector.m
//  raytracer
//
//  Created by Kurt Aadnøy on 14.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import "KAVector.h"


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

-(void)addVector:(KAVector*)vector {
    self.x += vector.x;
    self.y += vector.y;
    self.z += vector.z;
}

@end
