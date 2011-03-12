//
//  Ray.h
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Ray : NSObject {
    int _x, _y, _z, _length;
}

-(id)initWithX:(int)x y:(int)y z:(int)z andDepth:(int)length;

@end
