//
//  RLRFunctionLabel.m
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 1/16/16.
//  Copyright © 2016 Robert Reeves II. All rights reserved.
//

#import "RLRFunctionLabel.h"

@implementation RLRFunctionLabel

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 0, 5, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize)intrinsicContentSize {
    CGSize mySize = [super intrinsicContentSize];
    return CGSizeMake(mySize.width + 10, mySize.height + 10);
}

@end
