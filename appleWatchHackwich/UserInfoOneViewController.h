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
@property (strong, nonatomic) IBOutlet UISwitch *switchADDSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *switchDyslexiaSwitch;

@property (weak, nonatomic) UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblADHD;

@property (strong, nonatomic) NSArray *pageOneLabels;
@property (strong, nonatomic) NSArray *genders;
@property (strong, nonatomic) NSArray *pageTwoLabels;

@property NSInteger age;
@property NSInteger gender;
@property NSInteger ADHD;
@property NSInteger ADD;
@property NSInteger dyslexia;
@property NSUInteger pageIndex;
@end
