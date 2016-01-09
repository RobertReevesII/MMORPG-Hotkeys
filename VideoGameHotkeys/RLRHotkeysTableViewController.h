//
//  RLRHotkeysTableViewController.h
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 12/16/15.
//  Copyright © 2015 Robert Reeves II. All rights reserved.
//

@import UIKit;
#import "RLRGame.h"

@interface RLRHotkeysTableViewController : UITableViewController
@property (nonatomic, strong) RLRGame *game;
- (instancetype)initWithGame:(RLRGame *)game;
@end
