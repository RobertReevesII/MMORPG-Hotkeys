//
//  RLRHotkeyDetailTableViewCell.h
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 1/17/16.
//  Copyright © 2016 Robert Reeves II. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLRHotkey.h"

@interface RLRHotkeyDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *functionLabel;
@property (strong, nonatomic) IBOutlet UILabel *keysLabel;

@end
