//
//  UITextFieldNoCopyPaste.m
//  test_iOS_intern
//
//  Created by Admin on 16.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "UITextFieldNoCopyPaste.h"

@implementation UITextFieldNoCopyPaste

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))
        return NO;
    if (action == @selector(select:))
        return NO;
    if (action == @selector(selectAll:))
        return NO;
    if (action == @selector(cut:))
        return NO;
    if (action == @selector(copy:))
        return NO;
    
    
    return [super canPerformAction:action withSender:sender];
}



@end
