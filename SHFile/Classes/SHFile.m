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

+ (BOOL)setUpDocumentsDirectory
{
    NSURL *directoryURL = [self documentsDirectoryURL];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:nil];
}

#pragma mark - Clean
+ (BOOL)cleanUpTemporaryDirectory
{
    NSURL *directoryURL = [self temporaryDirectoryURL];
    return [[NSFileManager defaultManager] removeItemAtURL:directoryURL error:nil];
}

+ (BOOL)cleanUpDocumentsDirectory
{
    NSURL *directoryURL = [self documentsDirectoryURL];
    return [[NSFileManager defaultManager] removeItemAtURL:directoryURL error:nil];
}

#pragma mark - Directory URL
+ (NSURL *)temporaryDirectoryURL
{
    NSString *directoryPath = [NSTemporaryDirectory() stringByAppendingPathComponent:NSStringFromClass(self)]; // Use class name to create the directory path
    return [NSURL fileURLWithPath:directoryPath isDirectory:YES];
}

+ (NSURL *)documentsDirectoryURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    // Use class name to create the directory URL
    return [documentsURL URLByAppendingPathComponent:NSStringFromClass(self)];
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
+ (BOOL)saveAllInTemporaryDirectory:(NSArray *)files error:(NSError *__autoreleasing *)error
{
    for (SHFile *file in files) {
        if (![file saveInTemporaryDirectory:error]) return NO;
    }
    return YES;
}

+ (BOOL)saveAllInDocumentsDirectory:(NSArray *)files error:(NSError *__autoreleasing *)error
{
    for (SHFile * file in files) {
        if (![file saveInDocumentsDirectory:error]) return NO;
    }
    return YES;
}

- (BOOL)saveInTemporaryDirectory:(NSError *__autoreleasing *)error
{
    return [self saveAtFileURL:[self fileURLInTemporaryDirectory] error:error];
}

- (BOOL)saveInDocumentsDirectory:(NSError *__autoreleasing *)error
{
    return [self saveAtFileURL:[self fileURLInDocumentsDirectory] error:error];
}

- (BOOL)saveAtFileURL:(NSURL *)fileURL error:(NSError *__autoreleasing *)error
{
    if (![self.data length]) return YES;
    
    BOOL success = [self.data writeToURL:fileURL options:NSDataWritingAtomic error:error];
    if (success) self.data = nil;
        
    return success;
}

#pragma mark - Removing
+ (BOOL)deleteAllInTemporaryDirectory:(NSArray *)files error:(NSError *__autoreleasing *)error
{
    for (SHFile *file in files) {
        if (![file deleteInTemporaryDirectory:error]) return NO;
    }
    return YES;
}

+ (BOOL)deleteAllInDocumentsDirectory:(NSArray *)files error:(NSError *__autoreleasing *)error
{
    for (SHFile *file in files) {
        if (![file deleteInDocumentsDirectory:error]) return NO;
    }
    return YES;
}

- (BOOL)deleteInTemporaryDirectory:(NSError *__autoreleasing *)error
{
    return [self deleteAtFileURL:[self fileURLInTemporaryDirectory] error:error];
}

- (BOOL)deleteInDocumentsDirectory:(NSError *__autoreleasing *)error
{
    return [self deleteAtFileURL:[self fileURLInDocumentsDirectory] error:error];
}

- (BOOL)deleteAtFileURL:(NSURL *)fileURL error:(NSError *__autoreleasing *)error
{
    return [[NSFileManager defaultManager] removeItemAtURL:fileURL error:error];
}

#pragma mark - File URL
- (NSURL *)fileURLInTemporaryDirectory
{
    return [[SHFile temporaryDirectoryURL] URLByAppendingPathComponent:self.fileID];
}

- (NSURL *)fileURLInDocumentsDirectory
{
    return [[SHFile documentsDirectoryURL] URLByAppendingPathComponent:self.fileID];
}

@end
