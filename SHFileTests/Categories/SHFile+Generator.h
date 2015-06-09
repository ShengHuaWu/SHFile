//
//  SHFile+Generator.h
//  SHFile
//
//  Created by WuShengHua on 5/26/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "SHFile.h"

@interface SHFile (Generator)

+ (SHFile *)generateEmptyFile;
+ (SHFile *)generateTestFile;
+ (NSArray *)generateTestFiles;

@end
