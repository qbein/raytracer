//
//  Light.h
//  raytracer
//
//  Created by Kurt Aadnøy on 13.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "KAPoint3d.h"

@interface KALight : NSObject

@property (retain) KAPoint3d* position;
@property (retain) NSColor* color;

-(id)initWithPosition:(KAPoint3d*)aPosition
             andColor:(NSColor*)aColor;

@end
