//
//  SHTemporaryFileTests.m
//  SHFile
//
//  Created by WuShengHua on 5/25/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SHTemporaryFile.h"

@interface SHTemporaryFileTests : XCTestCase

@end

@implementation SHTemporaryFileTests

- (void)setUp
{
    [super setUp];
    [SHTemporaryFile setUp];
}

- (void)tearDown
{
    [SHTemporaryFile cleanUp];
    [super tearDown];
}

#pragma mark - Disable test
- (void)DISABLE_testSetUp
{
    XCTAssert([SHTemporaryFile setUp], @"Set up failed.");
}

- (void)DISABLE_testCleanUp
{
    XCTAssert([SHTemporaryFile cleanUp], @"Clean up failed.");
}

#pragma mark - Test
- (void)testSaveAndDeleteSingleFile
{
    SHTemporaryFile *file = [self generateFile];
    NSError *error = nil;
    BOOL success = [file saveData:&error];
    XCTAssert(success, @"Saving single file error %@.", [error localizedDescription]);
    
    success = [file deleteData:&error];
    XCTAssert(success, @"Deleting single file error %@.", [error localizedDescription]);
}

- (void)testSaveAndDeleteMultipleFiles
{
    NSArray *files = [self generateFiles];
    NSError *error = nil;
    BOOL success = [SHTemporaryFile saveAll:files error:&error];
    XCTAssert(success, @"Saving multiple files in temporary directory error %@.", [error localizedDescription]);
    
    success = [SHTemporaryFile deleteAll:files error:&error];
    XCTAssert(success, @"Deleting multiple files in temporary directory error %@.", [error localizedDescription]);
}

#pragma mark - File generater
- (SHTemporaryFile *)generateFile
{
    NSString *name = @"LargeImage.jpg";
    UIImage *image = [UIImage imageNamed:@"LargeImage"];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    return [SHTemporaryFile fileWithName:name data:data];
}

- (NSArray *)generateFiles
{
    NSMutableArray *files = [NSMutableArray array];
    for (NSInteger index = 0; index < 10; index ++) {
        SHTemporaryFile *file = [self generateFile];
        [files addObject:file];
    }
    
    return files;
}

@end
