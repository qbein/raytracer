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
@synthesize originZ;

-(id)initWithX:(float)x
             y:(float)y
          andZ:(float)z {
    if(![super init]) return nil;
    
    self.originX = x;
    self.originY = y;
    self.originZ = z;
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
