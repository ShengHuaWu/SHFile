//
//  SHFile.h
//  SHFile
//
//  Created by WuShengHua on 5/21/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHFile : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong ,readonly) NSString *fileID;

+ (BOOL)setUpTemporaryDirectory;
+ (BOOL)setUpDocumentsDirectory;

+ (BOOL)cleanUpTemporaryDirectory;
+ (BOOL)cleanUpDocumentsDirectory;

+ (instancetype)fileWithName:(NSString *)name data:(NSData *)data;

+ (BOOL)saveAllInTemporaryDirectory:(NSArray *)files error:(NSError *__autoreleasing *)error;
+ (BOOL)saveAllInDocumentsDirectory:(NSArray *)files error:(NSError *__autoreleasing *)error;
- (BOOL)saveInTemporaryDirectory:(NSError *__autoreleasing *)error;
- (BOOL)saveInDocumentsDirectory:(NSError *__autoreleasing *)error;

+ (BOOL)deleteAllInTemporaryDirectory:(NSArray *)files error:(NSError *__autoreleasing *)error;
+ (BOOL)deleteAllInDocumentsDirectory:(NSArray *)files error:(NSError *__autoreleasing *)error;
- (BOOL)deleteInTemporaryDirectory:(NSError *__autoreleasing *)error;
- (BOOL)deleteInDocumentsDirectory:(NSError *__autoreleasing *)error;

@end
