//
//  Ray.h
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Ray : NSObject {
}

@property int originX;
@property int originY;
@property int length;

-(id)initWithX:(int)x y:(int)y andMaxLength:(int)l;

@end
