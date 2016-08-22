//
//  ViewController.h
//  test_iOS_intern
//
//  Created by Admin on 09.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UITextFieldNoCopyPaste;

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *result;

@property (weak, nonatomic) IBOutlet UILabel *quantityOfCounts;
@property (weak, nonatomic) IBOutlet UITextFieldNoCopyPaste *input;
@property (assign, nonatomic) NSUInteger quantityOfCountsNum;

- (IBAction)coutBtnPressed:(id)sender;
- (IBAction)refreshBtnPressed:(id)sender;



@end

