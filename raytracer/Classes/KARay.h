//
//  Ray.h
//  raytracer
//
//  Created by Kurt Aadnøy on 12.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KAVector.h"
#import "KAPoint.h"

@interface KARay : NSObject

@property (retain) KAPoint* origin;
@property (retain) KAVector* direction;

-(id)initWithOrigin:(KAPoint*)anOrigin
       andDirection:(KAVector*)aDirection;

@end
