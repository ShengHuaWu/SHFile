//
//  SHDocumentsFileTests.m
//  SHFile
//
//  Created by WuShengHua on 5/25/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SHDocumentsFile.h"
#import "SHFile+Generator.h"

@interface SHDocumentsFileTests : XCTestCase

@property (nonatomic, strong) id mockFileManager;

@end

@implementation SHDocumentsFileTests

- (void)setUp
{
    [super setUp];
    [SHDocumentsFile setUp];    
}

- (void)tearDown
{
    [SHDocumentsFile cleanUp];
    [super tearDown];
}

#pragma mark - Acceptance test
- (void)testSaveAndDeleteSingleFile
{
    SHDocumentsFile *file = (SHDocumentsFile *)[SHDocumentsFile generateTestFile];
    NSError *error = nil;
    XCTAssert([file saveData:&error], @"Saving single file error %@.", [error localizedDescription]);
    
    XCTAssert([file deleteData:&error], @"Deleting single files error %@.", [error localizedDescription]);
}

- (void)testSaveAndDeleteMultipleFiles
{
    NSArray *files = [SHDocumentsFile generateTestFiles];
    NSError *error = nil;
    BOOL success = [SHDocumentsFile saveAll:files error:&error];
    XCTAssert(success, @"Saving multiple files error %@.", [error localizedDescription]);
    
    success = [SHDocumentsFile deleteAll:files error:&error];
    XCTAssert(success, @"Deleting multiple files error %@.", [error localizedDescription]);
}

- (void)testRetrieveData
{
    SHDocumentsFile *file = (SHDocumentsFile *)[SHDocumentsFile generateTestFile];
    NSError *error = nil;
    XCTAssert([file saveData:&error], @"Saving single file error %@.", [error localizedDescription]);
    
    XCTAssertNotNil([file retrieveData], @"Data is empty.");
}

@end
