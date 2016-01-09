//
//  AppDelegate.m
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 12/16/15.
//  Copyright © 2015 Robert Reeves II. All rights reserved.
//

#import "AppDelegate.h"
#import "RLRGamesTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self setDataController:[[RLRDataController alloc] init]];
    
    RLRGamesTableViewController *gtvc = [[RLRGamesTableViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gtvc];
    navController.title = @"Games";
    self.window.rootViewController = navController;
    
    // If first time running program, populate Core Data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults valueForKey:@"dataIsPreloaded"]) {
        NSLog(@"!dataIsPreloaded");
        [[self dataController] preloadGames];
        [defaults setObject:@YES forKey:@"dataIsPreloaded"];}

    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
