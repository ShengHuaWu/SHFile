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
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong) NSData *data;

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

#pragma mark - Directory URL
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

#pragma mark - Saving
+ (BOOL)saveAll:(NSArray *)files error:(NSError *__autoreleasing *)error
{
    for (SHFile *file in files) {
        if (![file save:error]) return NO;
    }
    
    return YES;
}

- (BOOL)save:(NSError *__autoreleasing *)error
{
    if (![self.data length]) return YES;
    
    BOOL success = [self.data writeToURL:[self fileURL] options:NSDataWritingAtomic error:error];
    
    if (success) self.data = nil;
    
    return success;
}

#pragma mark - Removing
- (BOOL)remove:(NSError *__autoreleasing *)error
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtURL:[self fileURL] error:error];
}

#pragma mark - File URL
- (NSURL *)fileURL
{
    return [[SHFile temporaryDirectoryURL] URLByAppendingPathComponent:self.fileID];
}

@end
