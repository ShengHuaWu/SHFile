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

- (void)testSetUpDirectory
{
    BOOL success = [SHFile setUpTemporaryDirectory];
    XCTAssert(success, @"Set up failed.");
}

@end
