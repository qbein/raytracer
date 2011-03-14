//
//  Light.h
//  raytracer
//
//  Created by Kurt Aadnøy on 13.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface Light : NSObject {
}

@property float positionX;
@property float positionY;
@property float positionZ;
@property float radius;
@property (retain) NSColor* color;

-(id)initWithX:(float)x
             y:(float)y
             z:(float)z
        radius:(float)radius
      andColor:(NSColor*)color;

@end
