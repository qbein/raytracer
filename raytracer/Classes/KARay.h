//
//  Ray.h
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KAVector.h"

@interface KARay : NSObject

@property float x;
@property float y;
@property float startZ;
@property float direction;

-(id)initWithX:(float)x
             y:(float)y
             z:(float)z
  andDirection:(float)direction;

-(KAVector*)vectorRepresentation;

@end
