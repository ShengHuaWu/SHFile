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
+ (BOOL)cleanTemporaryDirectory;

+ (instancetype)fileWithName:(NSString *)name data:(NSData *)data;

+ (BOOL)saveAll:(NSArray *)files error:(NSError *__autoreleasing *)error;
- (BOOL)save:(NSError *__autoreleasing *)error;

+ (BOOL)removeAll:(NSArray *)files error:(NSError *__autoreleasing *)error;
- (BOOL)remove:(NSError *__autoreleasing *)error;

@end
