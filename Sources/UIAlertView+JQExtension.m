//
//  UIAlertView+Extension.m
//  JQExtensions
//
//  Created by zjq on 2017/6/11.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UIAlertView+JQExtension.h"
#import <objc/runtime.h>
static char CLICK_BUTTON_BLOCK_BACK;
@implementation UIAlertView (JQExtension)

-(void)showWithButtonClickBlock:(ButtonClickBlock)buttonClickBlock
{
    if (buttonClickBlock) {
        self.ButtonClickBlock = buttonClickBlock;
        self.delegate = self;
    }
    
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (self.ButtonClickBlock) {
        self.ButtonClickBlock(buttonIndex);
    }
    
}
 

-(void)setButtonClickBlock:(void (^)(NSInteger))ButtonClickBlock
{
    objc_setAssociatedObject(self, &CLICK_BUTTON_BLOCK_BACK, ButtonClickBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void (^)(NSInteger))ButtonClickBlock
{
    return objc_getAssociatedObject(self, &CLICK_BUTTON_BLOCK_BACK);
}

@end
