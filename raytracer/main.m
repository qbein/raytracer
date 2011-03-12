//
//  main.m
//  
//  An raytracing Objective C kata.
//
//  Inspired by:
//  http://www.codermind.com/articles/Raytracer-in-C++-Introduction-What-is-ray-tracing.html
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Classes/Tracer.h"

int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSString* filename = @"scene.tiff";
    
    for(int i=0; i<argc; i++) {
        if(strlen(argv[i]) > 2 && strstr(argv[i], "-o") != NULL) {
            filename = [[NSString stringWithUTF8String:argv[i]] substringFromIndex:2];
        }
    }
    
    NSLog(@"Rendering scene to: %@", filename);
    
    Tracer *tracer = [[Tracer alloc] initWithWidth:100 height:100 andOutputFile:filename];
    Scene *scene = [[Scene alloc] init]; // TODO: initFromFile
    
    [tracer renderScene:scene];
    
    [scene release];
    [pool drain];
    
    NSLog(@"Done!");
    return 0;
}

