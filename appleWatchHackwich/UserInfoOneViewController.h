//
//  UserInfoViewController.h
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/6/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddInfoViewController.h"

@interface UserInfoOneViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UIPickerView *pickGenderPicker;
@property (strong, nonatomic) IBOutlet UITextField *txtAge;
@property (strong, nonatomic) IBOutlet UITextField *txtSleep;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapTohideKB;
@property (strong, nonatomic) IBOutlet UIButton *btnClear;

@property (weak, nonatomic) UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblADHD;

@property (strong, nonatomic) NSArray *pageOneLabels;
@property (strong, nonatomic) NSArray *genders;
@property (strong, nonatomic) NSArray *pageTwoLabels;

@property NSTimeInterval studyTime;
@property NSTimeInterval breakTime;

@property NSInteger studySliderInt;
@property NSInteger breakSliderInt;
@property NSInteger age;
@property NSInteger gender;
@property NSInteger ADHD;
@property NSInteger ADD;
@property NSInteger Dys;
@property NSInteger sleep;

@property NSUInteger pageIndex;
@end
