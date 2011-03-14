//
//  Primitive.h
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ray.h"

@interface Primitive : NSObject {   
}

-(float)findIntersectionsForRay:(Ray*)ray;

@end
