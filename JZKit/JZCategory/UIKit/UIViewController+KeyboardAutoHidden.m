//
//  UIViewController+KeyboardAutoHidden.m
//  JZKit
//
//  Created by YAN on 2018/4/26.
//

#import "UIViewController+KeyboardAutoHidden.h"

@implementation UIViewController (KeyboardAutoHidden)
#pragma mark - 键盘回收
- (void)jz_setKeyboardAutoHidden{
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    //单点手势
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapDismissKeyboard:)];
    
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    
    //键盘即将出现
    [notificationCenter addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQueue usingBlock:^(NSNotification *notification) {
        
        //判断是否正在显示
        if (self.isViewLoaded && self.view.window) {
            
            [self.view addGestureRecognizer:singleTapGesture];
            
            if ([self respondsToSelector:@selector(jz_keyboardWillShow:)]) {
                
                [self jz_keyboardWillShow:notification];
            }
        }
    }];
    
    //键盘即将消失
    [notificationCenter addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQueue usingBlock:^(NSNotification *notification) {
        
        //判断是否正在显示
        if (self.isViewLoaded && self.view.window) {
            
            [self.view removeGestureRecognizer:singleTapGesture];
            
            if ([self respondsToSelector:@selector(jz_keyboardWillDismiss:)]) {
                
                [self jz_keyboardWillDismiss:notification];
            }
            
        }
    }];
    
}
#pragma mark - 手势触发方法
- (void)backgroundTapDismissKeyboard:(id)sender{
    
    [self.view endEditing:YES];
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return [textField resignFirstResponder];
    
}
@end
