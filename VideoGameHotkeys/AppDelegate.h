//
//  AppDelegate.h
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 12/16/15.
//  Copyright © 2015 Robert Reeves II. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLRDataController.h"

extern BOOL * const dataIsPreloaded;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RLRDataController *dataController;

@end