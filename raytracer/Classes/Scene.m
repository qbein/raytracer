//
//  Scene.m
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "Scene.h"

#define OBJECT_LIMIT 10

@interface Scene (hidden)
+(int)intValueForKey:(NSString*)key inDictionary:(NSDictionary*)dict;
@end

@implementation Scene

+(int)intValueForKey:(NSString*)key inDictionary:(NSDictionary*)dict {
    return [[dict objectForKey:key] intValue];
}

-(id)init {
    if(![super init]) return nil;
    
    objects = [[NSMutableArray alloc] initWithCapacity:OBJECT_LIMIT];
    
    return self;
}

-(id)initFromFile:(NSString *)filename {
    if(![self init]) return nil;
    
    // TODO: when encountering an error in init, is it best practice to simply return nil as done below?
    
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    
    NSError* error = nil;
    NSString* jsonString = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&error];
    
    if(error) {
        NSLog(@"Error while reading scene file: %@", [error localizedDescription]);
        [parser release];
        return nil;
    }
    
    NSDictionary* scene = [parser objectWithString:jsonString error:&error];
    
    // TODO: are error handled correctly when releasing parser here?
    // Release parser as it's not required, simplifies error handling below
    [parser release];
    
    if(![scene isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Scene file did not parse as NSDictionary, invalid format. Was class [%@]", [scene class]);
        return nil;
    }
    
    if(error) {
        NSLog(@"Error parsing scene file: %@", [error localizedDescription]);
        return nil;
    }
    
    NSLog(@"%ld object(s) in scene", [scene count]);
    
    if([scene count] == 0) {
        NSLog(@"No objects in scene (JSON parse error?)");
        return nil;
    }
    else if([scene count] > OBJECT_LIMIT) {
        NSLog(@"Too many objects in scene (max OBJECT_LIMIT)");
        return nil;
    }
    
    BOOL* invalidObject = NO;
    [scene enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id object = nil;
 
        if([key isEqualToString:@"light"]) {
            object = [[Light alloc] initWithX:[Scene intValueForKey:@"x" inDictionary:obj]
                                            y:[Scene intValueForKey:@"y" inDictionary:obj]
                                            z:[Scene intValueForKey:@"z" inDictionary:obj]
                                       radius:[Scene intValueForKey:@"r" inDictionary:obj]
                                     andColor:[NSColor colorWithRGBString:[obj objectForKey:@"color"]]];
        }
        else if([key isEqualToString:@"sphere"]) {
            object = [[Sphere alloc] initWidthX:[Scene intValueForKey:@"x" inDictionary:obj]
                                              y:[Scene intValueForKey:@"y" inDictionary:obj]
                                              z:[Scene intValueForKey:@"z" inDictionary:obj]
                                         radius:[Scene intValueForKey:@"r" inDictionary:obj]
                                       andColor:[NSColor colorWithRGBString:[obj objectForKey:@"color"]]];
        }
        else {
            NSLog(@"Unknown primitive: %@", key);
            *stop = YES;
        }
        
        if(object) {
            [objects addObject:object];
            NSLog(@"Added %@", object);
        }
    }];
    
    if(invalidObject) {
        [objects release];
        return nil;
    }
    
    return self;
}

- (void)dealloc {
    [objects release];
    [super dealloc];
}

@end
