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

@property float originX;
@property float originY;
@property float originZ;

-(id)initWithX:(float)x
             y:(float)y
          andZ:(float)z;

@end
