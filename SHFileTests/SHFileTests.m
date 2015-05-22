//
//  SHFileTests.m
//  SHFileTests
//
//  Created by WuShengHua on 5/21/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SHFile.h"

@interface SHFileTests : XCTestCase

@end

@implementation SHFileTests

- (void)setUp
{
    [super setUp];
    [SHFile setUpTemporaryDirectory];
}

- (void)tearDown
{
    [SHFile cleanUpTemporaryDirectory];
    [super tearDown];
}

#pragma mark - Disable test
- (void)DISABLE_testSetUpTemporaryDirectory
{
    BOOL success = [SHFile setUpTemporaryDirectory];
    XCTAssert(success, @"Set up failed.");
}

- (void)DISABLE_testCleanTemporaryDirectory
{
    BOOL success = [SHFile cleanUpTemporaryDirectory];
    XCTAssert(success, @"Clean failed.");
}

#pragma mark - Test
- (void)testFileCreation
{
    NSString *name = @"readme.md";
    NSString *string = @"It is readme file.";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    SHFile *file = [SHFile fileWithName:name data:data];
    
    XCTAssert([name isEqualToString:file.name], @"File name is not correct.");
    XCTAssertNotNil(file.fileID, @"File identifier is empty.");
}

- (void)testSaveAndRemoveSingleFile
{
    SHFile *file = [self generateFile];
    NSError *error = nil;
    BOOL success = [file save:&error];
    XCTAssert(success, @"Saving single file error %@.", [error localizedDescription]);
    
    success = [file remove:&error];
    XCTAssert(success, @"Removing single file error %@.", [error localizedDescription]);
}

- (void)testSaveAndRemoveMultipleFiles
{
    NSArray *files = [self generateFiles];
    NSError *error = nil;
    BOOL success = [SHFile saveAll:files error:&error];
    XCTAssert(success, @"Saving multiple files error %@.", [error localizedDescription]);
    
    success = [SHFile removeAll:files error:&error];
    XCTAssert(success, @"Removing multiple files error %@.", [error localizedDescription]);
}

#pragma mark - File generater
- (SHFile *)generateFile
{
    NSString *name = @"LargeImage.jpg";
    UIImage *image = [UIImage imageNamed:@"LargeImage"];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    return [SHFile fileWithName:name data:data];
}

- (NSArray *)generateFiles
{
    NSMutableArray *files = [NSMutableArray array];
    for (NSInteger index = 0; index < 10; index ++) {
        SHFile *file = [self generateFile];
        [files addObject:file];
    }
    
    return files;
}

@end
