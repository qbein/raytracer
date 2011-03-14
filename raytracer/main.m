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
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    
    NSString* outputFile = @"scene.tiff";
    NSString* sceneFile = nil;
    
    for(int i=0; i<argc; i++) {
        if(strlen(argv[i]) > 2) {
            if(strstr(argv[i], "-h")) {
                NSLog(@"Usage: raytracer -s/scenefile.json -o/outputfile.tiff");
                return 0;
            }
            else if(strstr(argv[i], "-o") != NULL) {
                outputFile = [[NSString stringWithUTF8String:argv[i]] substringFromIndex:2];
            }
            else if(strstr(argv[i], "-s") != NULL) {
                sceneFile = [[NSString stringWithUTF8String:argv[i]] substringFromIndex:2];
            }
        }
    }
    
    if(sceneFile == nil) {
        NSLog(@"No scene file provided (-s option)");
        return 1;
    }
    if(![fileManager fileExistsAtPath:sceneFile]) {
        NSLog(@"Provided scene path [%@] does not exist", sceneFile);
        return 1;
    }
    
    NSLog(@"Rendering scene [{%@}] to: %@", sceneFile, outputFile);
    
    // Provided output file and scene file is valid, render the scene
    Tracer *tracer = [[Tracer alloc] initWithWidth:300 height:200 andOutputFile:outputFile];
    
    Scene *scene = [[Scene alloc] initFromFile:sceneFile];
    [scene retain];
    
    if(scene != nil) {
        [tracer renderScene:scene];
    }
        
    [fileManager release];
    [scene release];
    
    [pool drain];
    
    NSLog(@"Done!");
    return 0;
}

