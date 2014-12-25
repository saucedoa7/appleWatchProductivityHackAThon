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

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblADHD;
@property (weak, nonatomic) IBOutlet UIView *currentView;
@end