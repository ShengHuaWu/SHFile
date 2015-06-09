//
//  SHDownloaderTests.m
//  SHFile
//
//  Created by WuShengHua on 5/28/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SHDownloader.h"
#import <OCMock/OCMock.h>

@interface SHDownloaderTests : XCTestCase

@property (nonatomic, strong) SHDownloader *downloader;

@end

@implementation SHDownloaderTests

- (void)setUp
{
    [super setUp];
    self.downloader = [[SHDownloader alloc] init];
}

- (void)tearDown
{
    self.downloader = nil;
    [super tearDown];
}

#pragma mark - Unit test
- (void)testFetchData
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch Data"];

    id mockMainQueue = OCMPartialMock([NSOperationQueue mainQueue]);
    [[[mockMainQueue stub] andDo:^(NSInvocation *invocation) {
        [expectation fulfill];
    }] addOperationWithBlock:[OCMArg any]];
    
    [self.downloader fetchDataInBackground:nil handler:nil];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, @"Waiting error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Acceptance test
- (void)testFetchImage
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch Image"];
    
    NSURL *url = [NSURL URLWithString:@"http://tmacfitness.com/wp-content/uploads/2013/04/Beauty-of-nature-random-4884759-1280-800.jpg"];
    [self.downloader fetchDataInBackground:url handler:^(NSData *data, NSError *error) {

        XCTAssertNotNil(data, @"Data is empty.");
        XCTAssertNil(error, @"Download error: %@", [error localizedDescription]);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, @"Waiting error: %@", [error localizedDescription]);
    }];
}

@end
