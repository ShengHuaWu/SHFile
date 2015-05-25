//
//  SHFile.h
//  SHFile
//
//  Created by WuShengHua on 5/21/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import <Foundation/Foundation.h>

// This is an abstract class, please use its subclass instead.
@interface SHFile : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong ,readonly) NSString *fileID;

+ (instancetype)fileWithName:(NSString *)name data:(NSData *)data;

+ (BOOL)setUp;
+ (BOOL)cleanUp;

+ (BOOL)saveAll:(NSArray *)files error:(NSError *__autoreleasing *)error;
- (BOOL)saveData:(NSError *__autoreleasing *)error;
+ (BOOL)deleteAll:(NSArray *)files error:(NSError *__autoreleasing *)error;
- (BOOL)deleteData:(NSError *__autoreleasing *)error;

// The following methods are abstract
+ (NSURL *)directoryURL;
- (NSURL *)fileURL;

@end
