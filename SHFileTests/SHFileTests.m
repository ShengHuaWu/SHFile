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
#import "SHFile+Generator.h"
#import <OCMock/OCMock.h>

@interface SHFileTests : XCTestCase

@property (nonatomic, strong) id mockFileManager;

@end

@implementation SHFileTests

- (void)setUp
{
    [super setUp];
    self.mockFileManager = OCMPartialMock([NSFileManager defaultManager]);
}

- (void)tearDown
{
    [self.mockFileManager stopMocking];
    self.mockFileManager = nil;
    [super tearDown];
}

#pragma mark - Unit test
- (void)testSetUp
{
    [[self.mockFileManager expect] createDirectoryAtURL:[OCMArg any] withIntermediateDirectories:YES attributes:nil error:nil];
    [SHFile setUp];
    
    [self.mockFileManager verify];
}

- (void)testCleanUp
{
    [[self.mockFileManager expect] removeItemAtURL:[OCMArg any] error:nil];
    [SHFile cleanUp];
    
    [self.mockFileManager verify];
}

- (void)testSaveFile
{
    id mockData = OCMClassMock([NSData class]);
    [[[mockData stub] andReturnValue:@1] length];
    [[mockData expect] writeToURL:[OCMArg any] options:NSDataWritingAtomic error:[OCMArg anyObjectRef]];
    
    SHFile *file = [SHFile fileWithName:nil data:mockData];
    [file saveData:nil];
    
    [mockData verify];
}

- (void)testDeleteFile
{
    [[self.mockFileManager expect] removeItemAtURL:[OCMArg any] error:[OCMArg anyObjectRef]];
    
    SHFile *file = [SHFile generateEmptyFile];
    [file deleteData:nil];
    
    [self.mockFileManager verify];
}

- (void)testRetrieveData
{
    [[self.mockFileManager expect] fileExistsAtPath:[OCMArg any]];
    
    SHFile *file = [SHFile generateEmptyFile];
    [file retrieveData];
    
    [self.mockFileManager verify];
}

#pragma mark - Acceptance test
- (void)testFileCreation
{
    NSString *name = @"readme.md";
    NSString *string = @"It is readme file.";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    SHFile *file = [SHFile fileWithName:name data:data];
    
    XCTAssert([name isEqualToString:file.name], @"File name is not correct.");
    XCTAssertNotNil(file.fileID, @"File identifier is empty.");
}

@end
