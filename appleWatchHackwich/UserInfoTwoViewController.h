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
    
@property NSInteger ADD;
@property NSInteger Dys;
@end
