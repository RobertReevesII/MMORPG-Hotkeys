//
//  RLRHotkeyDetailViewController.m
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 1/8/16.
//  Copyright © 2016 Robert Reeves II. All rights reserved.
//

#import "RLRHotkeyDetailViewController.h"
#import "RLRHotkeysTableViewController.h"

@interface RLRHotkeyDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *functionLabel;
@property (strong, nonatomic) IBOutlet UILabel *keysLabel;
@end

@implementation RLRHotkeyDetailViewController

- (void)setFunctionLabel:(UILabel *)functionLabel {
    functionLabel.text = _hotkey.function;
}

- (void)setKeysLabel:(UILabel *)keysLabel {
    keysLabel.text = _hotkey.keys;
}

- (void)viewDidLoad {
    self.navigationItem.title = self.hotkey.game.name;
    NSLog(@"%@", self.navigationItem.title);
}

@end