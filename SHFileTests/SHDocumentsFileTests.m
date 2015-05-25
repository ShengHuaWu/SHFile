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

@interface SHDocumentsFileTests : XCTestCase

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

#pragma mark - Disable test
- (void)DISABLE_testSetUp
{
    XCTAssert([SHDocumentsFile setUp], @"Set up failed.");
}

- (void)DISABLE_testCleanUp
{
    XCTAssert([SHDocumentsFile cleanUp], @"Clean up failed.");
}

#pragma mark - Test
- (void)testSaveAndDeleteSingleFile
{
    SHDocumentsFile *file = [self generateFile];
    NSError *error = nil;
    
    BOOL success = [file saveData:&error];
    XCTAssert(success, @"Saving single file error %@.", [error localizedDescription]);
    
    success = [file deleteData:&error];
    XCTAssert(success, @"Deleting multiple files error %@.", [error localizedDescription]);
}

- (void)testSaveAndDeleteMultipleFiles
{
    NSArray *files = [self generateFiles];
    NSError *error = nil;
    BOOL success = [SHDocumentsFile saveAll:files error:&error];
    XCTAssert(success, @"Saving multiple files in documents directory error %@.", [error localizedDescription]);
    
    success = [SHDocumentsFile deleteAll:files error:&error];
    XCTAssert(success, @"Deleting multiple files in documents directory error %@.", [error localizedDescription]);
}

#pragma mark - File generater
- (SHDocumentsFile *)generateFile
{
    NSString *name = @"LargeImage.jpg";
    UIImage *image = [UIImage imageNamed:@"LargeImage"];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    return [SHDocumentsFile fileWithName:name data:data];
}

- (NSArray *)generateFiles
{
    NSMutableArray *files = [NSMutableArray array];
    for (NSInteger index = 0; index < 10; index ++) {
        SHDocumentsFile *file = [self generateFile];
        [files addObject:file];
    }
    return files;
}

@end
