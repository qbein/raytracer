//
//  main.m
//  
//  A personal ray tracing and Objective C research project.
//
//  Created by Kurt Aadn�y on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "Classes/KATracer.h"
#import "KAScene.h"

int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    
    NSString* outputFile = @"scene.jpg";
    NSString* sceneFile = nil;
    
    for(int i=0; i<argc; i++) {
        if(strlen(argv[i]) > 2) {
            if(strstr(argv[i], "-h")) {
                NSLog(@"Usage: raytracer -s/scenefile.json -o/outputfile.[jpg|tiff]");
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
    
    // Provided output file and scene file is valid, render the scene
    KATracer *tracer = [[KATracer alloc] initWithOutputFile:outputFile];
    
    KAScene *scene = [[KAScene alloc] initFromFile:sceneFile];
    
    if(scene != nil) {
        [tracer renderScene:scene];
    }
        
    [fileManager release];
    [scene release];
    
    [pool drain];
    
    NSLog(@"Done!");
    return 0;
}

