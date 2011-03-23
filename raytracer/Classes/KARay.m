//
//  Ray.m
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "KARay.h"

@implementation KARay

@synthesize origin;
@synthesize direction;

-(id)initWithOrigin:(KAPoint3d*)anOrigin
       andDirection:(KAVector3d*)aDirection {
    if(![super init]) return nil;
    
    self.origin = anOrigin;
    self.direction = aDirection;
    
    return self;
}

- (void)dealloc {
    [origin release];
    [direction release];
    [super dealloc];
}

-(KARay*)rayBouncedOfSphereAt:(KAPoint3d*)point
            usingNormalVector:(KAVector3d*)normal {
    
    // c1 = -dot_product( N, V )
    // Rl = V + (2 * N * c1 )
    
    float c1 = [self.direction dotProduct:normal] * -1;
    KAVector3d* bounceVector = [[normal multiplyByFloat:2.0f] multiplyByFloat:c1];
    
    // float reflet = 2.0f * (viewRay.dir * n);
    
    KARay* bouncedRay = [[KARay alloc] initWithOrigin:point
                                         andDirection:[self.direction addVector:bounceVector]];
    
    return [bouncedRay autorelease];
}

-(NSString*)description {
    return [NSString stringWithFormat:@"origin %@ - direction %@", self.origin, self.direction];
}

-(KARay*) copyWithZone:(NSZone *)zone {
    return [[[KARay alloc] initWithOrigin:self.origin
                             andDirection:self.direction] autorelease];
}

@end
