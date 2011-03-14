//
//  Light.m
//  raytracer
//
//  Created by Kurt Aadnøy on 13.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import "KALight.h"

@implementation KALight

@synthesize positionX;
@synthesize positionY;
@synthesize positionZ;
@synthesize radius;
@synthesize color;

-(id)initWithX:(float)x
             y:(float)y
             z:(float)z
        radius:(float)r
      andColor:(NSColor*)c {
    if(![super init]) return nil;
    
    self.positionX = x;
    self.positionY = y;
    self.positionZ = z;
    self.radius = r;
    self.color = c;
    
    return self;
}

- (void)dealloc {
    [color dealloc];
    [super dealloc];
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@ x:%f y:%f z:%f r:%f color:%@", [self class], self.positionX, self.positionY, self.positionZ, self.radius, self.color];
}

@end
