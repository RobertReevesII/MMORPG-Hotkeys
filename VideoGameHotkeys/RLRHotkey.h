//
//  RLRHotkey.h
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 12/16/15.
//  Copyright © 2015 Robert Reeves II. All rights reserved.
//

@import Foundation;
@import UIKit;
@import CoreData;
#import "RLRGame.h"

@interface RLRHotkey : NSManagedObject

@property (nonatomic) NSString *keys;
@property (nonatomic) NSString *function;
@property (nonatomic, strong) RLRGame *game;
@end
