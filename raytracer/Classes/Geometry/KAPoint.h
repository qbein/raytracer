//
//  Point.h
//  raytracer
//
//  Created by Kurt Aadnøy on 14.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

@class KAVector;

@interface KAPoint : NSObject

@property float x;
@property float y;
@property float z;

+(id)pointWithX:(float)anX y:(float)aY andZ:(float)aZ;

-(KAPoint*)addPoint:(KAPoint*)point;

-(KAPoint*)addVector:(KAVector*)aVector;

@end
