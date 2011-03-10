//
//  main.m
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Classes/Tracer.h"

int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    Tracer *tracer = [[Tracer alloc] initWithWidth:100 andHeight:100];
    
    Scene *scene = [[Scene alloc] init];
    [tracer renderScene:scene];
    
    [scene release];
    [pool drain];
    
    NSLog(@"Done!");
    return 0;
}

