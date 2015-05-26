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
#import "SHFile+Generator.h"

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
    SHTemporaryFile *file = (SHTemporaryFile *)[SHTemporaryFile generateTestFile];
    NSError *error = nil;
    XCTAssert([file saveData:&error], @"Saving single file error %@.", [error localizedDescription]);
    
    XCTAssert([file deleteData:&error], @"Deleting single file error %@.", [error localizedDescription]);
}

- (void)testSaveAndDeleteMultipleFiles
{
    NSArray *files = [SHTemporaryFile generateTestFiles];
    NSError *error = nil;
    BOOL success = [SHTemporaryFile saveAll:files error:&error];
    XCTAssert(success, @"Saving multiple files error %@.", [error localizedDescription]);
    
    success = [SHTemporaryFile deleteAll:files error:&error];
    XCTAssert(success, @"Deleting multiple files error %@.", [error localizedDescription]);
}

- (void)testRetrieveData
{
    SHTemporaryFile *file = (SHTemporaryFile *)[SHTemporaryFile generateTestFile];
    NSError *error = nil;
    XCTAssert([file saveData:&error], @"Saving single file error: %@", [error localizedDescription]);
    
    XCTAssertNotNil([file retrieveData], @"Data is empty.");
}

@end
