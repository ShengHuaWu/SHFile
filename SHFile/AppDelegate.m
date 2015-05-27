//
//  AppDelegate.m
//  SHFile
//
//  Created by WuShengHua on 5/21/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "AppDelegate.h"
#import "SHTemporaryFile.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [SHTemporaryFile setUp];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [SHTemporaryFile cleanUp];
}

@end
