//
//  Primitive.h
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KARay.h"

@interface KAPrimitive : NSObject {   
}

-(float)findIntersectionsForRay:(KARay*)ray;

@end
