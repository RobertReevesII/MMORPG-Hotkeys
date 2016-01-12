//
//  RLRHotkeyDetailViewController.h
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 1/8/16.
//  Copyright © 2016 Robert Reeves II. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLRHotkey.h"

@interface RLRHotkeyDetailViewController : UIViewController  <UINavigationBarDelegate>
@property (nonatomic, strong) RLRHotkey *hotkey;
@end
