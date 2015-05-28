//
//  ViewController.m
//  SHFile
//
//  Created by WuShengHua on 5/21/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "ViewController.h"
#import "SHTemporaryFile.h"
#import "SHDownloader.h"

@interface ViewController ()

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) SHDownloader *downloader;

@end

@implementation ViewController

#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    self.downloader = [[SHDownloader alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://tmacfitness.com/wp-content/uploads/2013/04/Beauty-of-nature-random-4884759-1280-800.jpg"];
    [self.downloader fetchDataInBackground:url handler:^(NSData *data, NSError *error) {
        if ([data length]) {
            SHTemporaryFile *file = [SHTemporaryFile fileWithName:@"LargeImage" data:data];
            if ([file saveData:&error]) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[file retrieveData]]];
                [imageView sizeToFit];
                [self.scrollView addSubview:imageView];
                self.scrollView.contentSize = imageView.frame.size;
            } else {
                NSLog(@"Saving error: %@", [error localizedDescription]);
            }
        } else {
            NSLog(@"Download error: %@", [error localizedDescription]);
        }
    }];
}

- (void)viewDidLayoutSubviews
{
    self.scrollView.frame = self.view.bounds;
}

@end
