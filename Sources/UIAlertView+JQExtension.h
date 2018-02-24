//
//  UIAlertView+JQExtension.h
//  JQExtensions
//
//  Created by zjq on 2017/6/11.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ButtonClickBlock)(NSInteger buttonIndex);
@interface UIAlertView (JQExtension)

@property (strong, nonatomic) void(^ButtonClickBlock)(NSInteger buttonIndex);

- (void)showWithButtonClickBlock:(ButtonClickBlock)buttonClickBlock;

@end
