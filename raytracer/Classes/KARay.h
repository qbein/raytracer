//
//  Ray.h
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "KAVector3d.h"
#import "KAPoint3d.h"

@interface KARay : NSObject

@property (retain) KAPoint3d* origin;
@property (retain) KAVector3d* direction;

-(id)initWithOrigin:(KAPoint3d*)anOrigin
       andDirection:(KAVector3d*)aDirection;

@end
