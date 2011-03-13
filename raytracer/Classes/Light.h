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

@property int positionX;
@property int positionY;
@property int positionZ;
@property int radius;
@property (retain) NSColor* color;

-(id)initWithX:(int)x y:(int)y z:(int)z radius:(int)radius andColor:(NSColor*)color;

@end
