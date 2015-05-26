//
//  SHFile+Generator.m
//  SHFile
//
//  Created by WuShengHua on 5/26/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "SHFile+Generator.h"
#import <UIKit/UIKit.h>

@implementation SHFile (Generator)

+ (SHFile *)generateTestFile
{
    NSString *name = @"LargeImage.jpg";
    UIImage *image = [UIImage imageNamed:@"LargeImage"];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    return [self fileWithName:name data:data];
}

+ (NSArray *)generateTestFiles
{
    NSMutableArray *files = [NSMutableArray array];
    for (NSInteger index = 0; index < 10; index ++) {
        SHFile *file = [self generateTestFile];
        [files addObject:file];
    }
    return files;
}

@end
