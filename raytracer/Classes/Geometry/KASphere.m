 //
//  Sphere.m
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "KASphere.h"
#import "KAPoint3d.h"
#import "KARay.h"
#import "KAMaterial.h"

@implementation KASphere

@synthesize position;
@synthesize radius;
@synthesize material;

-(id)initWithPosition:(KAPoint3d*)aPosition
               radius:(float)aRadius
             andMaterial:(KAMaterial*)aMaterial {
    if(![super init]) return nil;
    
    self.position = aPosition;
    self.radius = aRadius;
    self.material = aMaterial;
    
    return self;
}

- (void)dealloc {
    [position dealloc];
    [material dealloc];
    [super dealloc];
}

-(float)findIntersectionForRay:(KARay *)ray
                   withMaxDepth:(float)maxDepth {
    float intersectionDistance = maxDepth;
    
    // Find the distance vector between the sphere center and the ray origin
    KAVector3d* distance = [KAVector3d vectorFromPoint:self.position
                                    substractedByPoint:ray.origin];
    
    double B = [[distance multiplyByVector:ray.direction] dot];
    double D = B * B - [[distance multiplyByVector:distance] dot] + self.radius * self.radius;
    
    if(D < 0.0f) {
        return maxDepth;
    }
    
    double t0 = B - sqrt(D);
    double t1 = B + sqrt(D);
        
    if((t0 > 0.1f) && (t0 < intersectionDistance)) {
        intersectionDistance = (float)t0;
    }
    if((t1 > 0.1f) && (t1 < intersectionDistance)) {
        intersectionDistance = (float)t1;
    }
    
    return intersectionDistance;
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@ position %@ radius %f material %@", [self class], self.position, self.radius, self.material];
}

@end
