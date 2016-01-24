//
//  AppDelegate.m
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 12/16/15.
//  Copyright © 2015 Robert Reeves II. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self setDataController:[[RLRDataController alloc] init]];

    // If first time running the program then populate Core Data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults valueForKey:@"dataIsPreloaded"]) {
        [[self dataController] preloadGames];
        [defaults setObject:@YES forKey:@"dataIsPreloaded"];}

    HomeViewController *hvc = [[HomeViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:hvc];

    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
