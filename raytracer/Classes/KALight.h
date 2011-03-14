//
//  Light.h
//  raytracer
//
//  Created by Kurt Aadnøy on 13.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "KAPoint.h"

@interface KALight : NSObject

@property (retain) KAPoint* position;
@property float radius;
@property (retain) NSColor* color;

-(id)initWithPosition:(KAPoint*)aPosition
               radius:(float)aRadius
             andColor:(NSColor*)aColor;

@end
