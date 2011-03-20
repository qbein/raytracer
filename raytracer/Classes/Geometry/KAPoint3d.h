//
//  Point.h
//  raytracer
//
//  Created by Kurt Aadnøy on 14.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

@class KAVector3d;

@interface KAPoint3d : NSObject <NSCopying>

@property float x;
@property float y;
@property float z;

+(id)pointWithX:(float)anX y:(float)aY andZ:(float)aZ;

-(KAPoint3d*)addPoint:(KAPoint3d*)point;

-(KAPoint3d*)addVector:(KAVector3d*)aVector;

@end
