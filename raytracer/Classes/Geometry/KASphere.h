//
//  Sphere.h
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

@class KAPoint3d;
@class KAVector3d;
@class KAMaterial;
@class KARay;

@interface KASphere : NSObject

@property (retain) KAPoint3d* position;
@property float radius;
@property (retain) KAMaterial* material;

-(id)initWithPosition:(KAPoint3d*)aPosition
         radius:(float)aRadius
       andMaterial:(KAMaterial*)aMaterial;

-(float)findIntersectionForRay:(KARay*)ray
                   withMaxDepth:(float)maxDepth;

@end
