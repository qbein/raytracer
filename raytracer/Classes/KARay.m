//
//  Ray.m
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "KARay.h"

@implementation KARay

@synthesize x;
@synthesize y;
@synthesize startZ;
@synthesize direction;

-(id)initWithX:(float)anX
             y:(float)aY
             z:(float)aZ
  andDirection:(float)aDirection {
    if(![super init]) return nil;
    
    self.x = anX;
    self.y = aY;
    self.startZ = aZ;
    self.direction = aDirection;
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

-(KAVector*)vectorRepresentation {
    KAVector* vector = [[KAVector alloc] initWithX:self.x y:self.y andZ:self.startZ];
    return [vector autorelease];
}

@end
