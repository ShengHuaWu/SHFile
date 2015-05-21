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
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSetUpTemporaryDirectory
{
    BOOL success = [SHFile setUpTemporaryDirectory];
    XCTAssert(success, @"Set up failed.");
}

- (void)testCleanTemporaryDirectory
{
    BOOL success = [SHFile cleanTemporaryDirectory];
    XCTAssert(success, @"Clean failed.");
}

- (void)testFileCreation
{
    NSString *name = @"readme.md";
    NSString *string = @"It is readme file.";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    SHFile *file = [SHFile fileWithName:name data:data];
    
    XCTAssert([name isEqualToString:file.name], @"File name is not correct.");
    XCTAssert([string isEqualToString:[[NSString alloc] initWithData:file.data encoding:NSUTF8StringEncoding]], @"File data is not correct.");
    XCTAssertNotNil(file.fileID, @"File identifier is empty.");
}

@end
