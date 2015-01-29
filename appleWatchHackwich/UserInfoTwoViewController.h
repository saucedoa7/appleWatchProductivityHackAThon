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

#pragma mark TableView Properties

@property NSMutableArray *switchStates;
@property NSMutableArray *disabilities;
@property (strong, nonatomic) IBOutlet UITableView *disabilitiesTableView;

@end
