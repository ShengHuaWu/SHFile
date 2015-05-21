//
//  SHFile.m
//  SHFile
//
//  Created by WuShengHua on 5/21/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "SHFile.h"

@interface SHFile ()

@property (nonatomic, strong ,readwrite) NSString *fileID;

@end

@implementation SHFile

#pragma mark - Set up
+ (BOOL)setUpTemporaryDirectory
{
    NSURL *directoryURL = [self temporaryDirectoryURL];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:nil];
}

#pragma mark - Clean
+ (BOOL)cleanTemporaryDirectory
{
    NSURL *directoryURL = [self temporaryDirectoryURL];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtURL:directoryURL error:nil];
}

+ (NSURL *)temporaryDirectoryURL
{
    NSString *directoryPath = [NSTemporaryDirectory() stringByAppendingPathComponent:NSStringFromClass(self)]; // Use class name to create the directory path
    return [NSURL fileURLWithPath:directoryPath isDirectory:YES];
}

#pragma mark - Creation
+ (instancetype)fileWithName:(NSString *)name data:(NSData *)data
{
    NSString *fileID = [[NSProcessInfo processInfo] globallyUniqueString];
    SHFile *file = [[SHFile alloc] initWithFileID:fileID];
    file.name = name;
    file.data = data;
    
    return file;
}

#pragma mark - Designated initializer
- (instancetype)initWithFileID:(NSString *)fileID
{
    self = [super init];
    if (self) {
        _fileID = fileID;
    }
    return self;
}

@end
