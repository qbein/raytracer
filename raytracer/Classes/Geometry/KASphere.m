//
//  Sphere.m
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "KASphere.h"
#import "KAPoint.h"
#import "KARay.h"

@implementation KASphere

@synthesize position;
@synthesize radius;
@synthesize color;

-(id)initWithPosition:(KAPoint*)aPosition
               radius:(float)aRadius
             andColor:(NSColor*)aColor {
    if(![super init]) return nil;
    
    self.position = aPosition;
    self.radius = aRadius;
    self.color = aColor;
    
    return self;
}

- (void)dealloc {
    [position dealloc];
    [color dealloc];
    [super dealloc];
}

-(float)findIntersectionsForRay:(KARay *)ray
                   withMaxDepth:(float)maxDepth {
    float intersectionDistance = maxDepth;
    
    // Find the distance vector between the sphere center and the ray origin
    KAVector* distance = [KAVector vectorFromPoint:self.position substractedBy:ray.origin];
    
    [distance retain];
    
    double B = [[distance multiplyWith:ray.direction] summarize];
    double D = B*B - [[distance multiplyWith:distance] summarize] + self.radius * self.radius;
    
    [distance release];
    
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
    return [NSString stringWithFormat:@"%@ position %@ radius %f color %@", [self class], self.position, self.radius, self.color];
}

@end
