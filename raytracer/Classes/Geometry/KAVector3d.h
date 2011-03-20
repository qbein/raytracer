//
//  Vector.h
//  raytracer
//
//  Created by Kurt Aadnøy on 14.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EPSILON 1.0e-6f

@class KAPoint3d;

@interface KAVector3d : NSObject <NSCopying>

@property float x, y, z;

-(id)initWithX:(float)ax
             y:(float)ay
          andZ:(float)az;

+(id)vectorFromPoint:(KAPoint3d*)aPoint;

+(id)vectorFromPoint:(KAPoint3d*)pointA
  substractedByPoint:(KAPoint3d*)pointB;

+(id)vectorFromPoint:(KAPoint3d*)pointA
        addedByPoint:(KAPoint3d*)pointB;

-(KAVector3d*)addVector:(KAVector3d*)aVector;

-(KAVector3d*)substractVector:(KAVector3d*)aVector;

-(KAVector3d*)multiplyByVector:(KAVector3d*)aVector;

-(KAVector3d*)divideByVector:(KAVector3d*)aVector;

-(KAVector3d*)addFloat:(float)aFloat;

-(KAVector3d*)substractFloat:(float)aFloat;

-(KAVector3d*)multiplyByFloat:(float)aFloat;

-(KAVector3d*)divideByFloat:(float)aFloat;

-(float)dot;

-(float)length;

-(KAVector3d*)normalizedVector;

@end
