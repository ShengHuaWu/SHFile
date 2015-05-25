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
    [SHFile setUpDocumentsDirectory];
}

- (void)tearDown
{
    [SHFile cleanUpTemporaryDirectory];
    [SHFile cleanUpDocumentsDirectory];
    [super tearDown];
}

#pragma mark - Disable test
- (void)DISABLE_testSetUpTemporaryDirectory
{
    BOOL success = [SHFile setUpTemporaryDirectory];
    XCTAssert(success, @"Set up temporary directory failed.");
}

- (void)DISABLE_testCleanTemporaryDirectory
{
    BOOL success = [SHFile cleanUpTemporaryDirectory];
    XCTAssert(success, @"Clean up temporary directory failed.");
}

- (void)DISABLE_testSetUpDocumentsDirectory
{
    BOOL success = [SHFile setUpDocumentsDirectory];
    XCTAssert(success, @"Set up documents directory failed.");
}

- (void)DISABLE_testCleanUpDocumentsDirectory
{
    BOOL success = [SHFile cleanUpDocumentsDirectory];
    XCTAssert(success, @"Clean up documents directory failed.");
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

- (void)testSaveAndDeleteSingleFileInTemporaryDirectory
{
    SHFile *file = [self generateFile];
    NSError *error = nil;
    BOOL success = [file saveInTemporaryDirectory:&error];
    XCTAssert(success, @"Saving single file in temporary directory error %@.", [error localizedDescription]);
    
    success = [file deleteInTemporaryDirectory:&error];
    XCTAssert(success, @"Deleting single file in temporary directory error %@.", [error localizedDescription]);
}

- (void)testSaveAndDeleteMultipleFilesInTemporaryDirectory
{
    NSArray *files = [self generateFiles];
    NSError *error = nil;
    BOOL success = [SHFile saveAllInTemporaryDirectory:files error:&error];
    XCTAssert(success, @"Saving multiple files in temporary directory error %@.", [error localizedDescription]);
    
    success = [SHFile deleteAllInTemporaryDirectory:files error:&error];
    XCTAssert(success, @"Deleting multiple files in temporary directory error %@.", [error localizedDescription]);
}

- (void)testSaveSingleAndDeleteFileInDocumentsDirectory
{
    SHFile *file = [self generateFile];
    NSError *error = nil;
    
    BOOL success = [file saveInDocumentsDirectory:&error];
    XCTAssert(success, @"Saving single file in documents directory error %@.", [error localizedDescription]);
    
    success = [file deleteInDocumentsDirectory:&error];
    XCTAssert(success, @"Deleting multiple files in documents directory error %@.", [error localizedDescription]);

}

- (void)testSaveAndDeleteMultipleFilesInDocumentsDirectory
{
    NSArray *files = [self generateFiles];
    NSError *error = nil;
    BOOL success = [SHFile saveAllInDocumentsDirectory:files error:&error];
    XCTAssert(success, @"Saving multiple files in documents directory error %@.", [error localizedDescription]);
    
    success = [SHFile deleteAllInDocumentsDirectory:files error:&error];
    XCTAssert(success, @"Deleting multiple files in documents directory error %@.", [error localizedDescription]);
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
