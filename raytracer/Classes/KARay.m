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

-(id)initWithOrigin:(KAPoint*)anOrigin
       andDirection:(KAVector*)aDirection {
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

-(NSString*)description {
    return [NSString stringWithFormat:@"origin %@ - direction %@", self.origin, self.direction];
}

@end
