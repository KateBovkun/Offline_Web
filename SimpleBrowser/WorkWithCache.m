//
//  WorkWithCache.m
//  SimpleBrowser
//
//  Created by Ekaterina Bovkun on 3/21/12.
//  Copyright (c) 2012 All-Seeing Interactive. All rights reserved.
//

#import "WorkWithCache.h"

@implementation WorkWithCache

+(NSString *)getCachesPath {
	NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString * path = [paths objectAtIndex:0];
	return path;
}

+(NSString*)getCachePath
{
    NSString* cachesPath = [[self getCachesPath] stringByAppendingString:@"/"];
    NSString* name = [cachesPath stringByAppendingString:[[NSBundle mainBundle] bundleIdentifier]];
    NSLog(@"%@", name);
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:name error:nil];
    for (NSString *tString in dirContents) 
    {
        if (/*[tString hasSuffix:@".db"]*/ [tString isEqualToString:@"Cache.db"]) 
        {
            NSLog(@"%@", tString);
            cachesPath = [name stringByAppendingString:@"/"];
            return [cachesPath stringByAppendingString:tString];
        }
    }
    return nil;
}

@end
