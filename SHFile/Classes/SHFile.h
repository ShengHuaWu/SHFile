//
//  SHFile.h
//  SHFile
//
//  Created by WuShengHua on 5/21/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHFile : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong ,readonly) NSString *fileID;

+ (BOOL)setUpTemporaryDirectory;

+ (instancetype)fileWithName:(NSString *)name data:(NSData *)data;

@end
