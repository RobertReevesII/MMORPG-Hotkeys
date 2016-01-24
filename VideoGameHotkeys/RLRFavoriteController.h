//
//  RLRFavoriteController.h
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 1/22/16.
//  Copyright © 2016 Robert Reeves II. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLRGame.h"

@interface RLRFavoriteController : NSObject
- (RLRGame *)gameForTitle:(NSString *)title;
@end
