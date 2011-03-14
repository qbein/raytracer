//
//  Light.m
//  raytracer
//
//  Created by Kurt Aadnøy on 13.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import "KALight.h"

@implementation KALight

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
    [color dealloc];
    [super dealloc];
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@ position %@ radius %f color:%@", [self class], self.position, self.radius, self.color];
}

@end
