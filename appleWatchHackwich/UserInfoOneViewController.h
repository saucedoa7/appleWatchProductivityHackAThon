//
//  UserInfoViewController.h
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/6/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoOneViewController : UIViewController
//           AKA PageContentVC
@property (strong, nonatomic) IBOutlet UIPickerView *pickGenderPicker;
@property (strong, nonatomic) IBOutlet UITextField *txtAge;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapTohideKB;
@property (strong, nonatomic) IBOutlet UISwitch *SwtchADHDSwitch;
@property (weak, nonatomic) IBOutlet UIView *userInfoOneView;

@property (weak, nonatomic) UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblADHD;
@property (weak, nonatomic) IBOutlet UIView *currentView;

@property (strong, nonatomic) NSArray *pageOneLabels;
@property (strong, nonatomic) NSArray *genders;

@property (weak, nonatomic) IBOutlet UIView *userInfoTwoView;
@property (strong, nonatomic) NSArray *pageTwoLabels;

@property NSInteger age;
@property NSInteger gender;
@property NSInteger ADHD;
@property NSUInteger pageIndex;
@end
