//
//  UserInfoTwoViewController.h
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/24/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoTwoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISwitch *switchADDSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *switchDyslexiaSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *SwtchADHDSwitch;

@property NSInteger age;
@property NSInteger gender;
@property NSInteger ADD;
@property NSInteger Dys;
@property NSInteger ADHD;
@property NSInteger studyInt;
@property NSInteger breakInt;

@end
