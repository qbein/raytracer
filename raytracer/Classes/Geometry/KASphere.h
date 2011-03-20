//
//  Sphere.h
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "KAPrimitive.h"

@class KAPoint3d;
@class KAMaterial;

@interface KASphere : KAPrimitive

@property (retain) KAPoint3d* position;
@property float radius;
@property (retain) KAMaterial* material;

-(id)initWithPosition:(KAPoint3d*)aPosition
         radius:(float)aRadius
       andMaterial:(KAMaterial*)aMaterial;

@end
