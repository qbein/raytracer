//
//  Primitive.h
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

@class KARay;

@interface KAPrimitive : NSObject {   
}

-(float)findIntersectionsForRay:(KARay*)ray
                   withMaxDepth:(float)maxDepth;

@end
