//
//  SHFile.m
//  SHFile
//
//  Created by WuShengHua on 5/21/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "SHFile.h"

@implementation SHFile

#pragma mark - Set up
+ (BOOL)setUpTemporaryDirectory
{
    NSString *directoryPath = [NSTemporaryDirectory() stringByAppendingPathComponent:NSStringFromClass(self)]; // Use class name to create the directory path
    NSURL *directoryURL = [NSURL fileURLWithPath:directoryPath isDirectory:YES];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:nil];
}

#pragma mark - Creation
+ (instancetype)fileWithName:(NSString *)name data:(NSData *)data
{
    return nil;
}

@end
