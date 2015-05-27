//
//  ViewController.m
//  SHFile
//
//  Created by WuShengHua on 5/21/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "ViewController.h"
#import "SHTemporaryFile.h"
#import "SHFile+Generator.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SHTemporaryFile *file = (SHTemporaryFile *)[SHTemporaryFile generateTestFile];
    NSError *error = nil;
    if ([file saveData:&error]) {
        NSData *data = [file retrieveData];
        UIImage *image = [UIImage imageWithData:data];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imageView sizeToFit];
        [self.view addSubview:imageView];
    } else {
        NSLog(@"Saving error: %@", [error localizedDescription]);
    }
}

@end
