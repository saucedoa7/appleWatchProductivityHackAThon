//
//  AddInfoViewController.m
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/24/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "AddInfoViewController.h"
#import "UserInfoOneViewController.h"

@interface AddInfoViewController ()

@property NSInteger studySliderInt;
@property NSInteger breakSliderInt;
@property NSInteger age;
@property NSInteger gender;
@property NSInteger ADHD;

@end

@implementation AddInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

    self.studySliderInt = 0;
    self.breakSliderInt = 0;

    NSLog(@"1st %ld", (long)self.studySliderInt);
    NSLog(@"1st %ld", (long)self.breakSliderInt);
}

- (IBAction)onStudySlide:(UISlider *)sender {

    UserInfoOneViewController *age = [UserInfoOneViewController new];
    UserInfoOneViewController *ADHDSwitch =[UserInfoOneViewController new];
    UserInfoOneViewController *pickGender = [UserInfoOneViewController new];

    self.lblStudyTime.text =[[NSString alloc] initWithFormat:@"%.0fm", self.sldStudySlider.value];
    self.studySliderInt = self.sldStudySlider.value;
    age.txtAge.text = @"0";
    [ADHDSwitch.SwtchADHDSwitch setOn:NO animated:YES];
    [pickGender.pickGenderPicker selectRow:0 inComponent:0 animated:YES];
}
- (IBAction)onBreakTime:(UISlider *)sender {
    UserInfoOneViewController *ADHDSwitch =[UserInfoOneViewController new];
    UserInfoOneViewController *pickGender = [UserInfoOneViewController new];

    self.lblBreakTime.text = [[NSString alloc] initWithFormat:@"%.0fm", self.sldBreakSlider.value];
    self.breakSliderInt = self.sldBreakSlider.value;
    [ADHDSwitch.SwtchADHDSwitch setOn:NO animated:YES];
    [pickGender.pickGenderPicker selectRow:0 inComponent:0 animated:YES];
}


- (IBAction)onDoneButtonPressed:(UIButton *)sender {

    if (self.age != 0 || self.gender != 0) {
        self.studySliderInt = 0;
        self.breakSliderInt = 0;
    }

    if (self.age == 0 || self.gender == 0){
        self.age = 0;
        self.gender = 0;
        self.ADHD = 0;
        self.studySliderInt = self.sldStudySlider.value;
        self.breakSliderInt = self.sldBreakSlider.value;
    }

    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    [currentSettings setInteger:self.age forKey:@"CurrentAge"];
    [currentSettings setInteger:self.gender forKey:@"CurrentGender"];
    [currentSettings setInteger:self.ADHD forKey:@"CurrentADHD"];
    [currentSettings setInteger:self.studySliderInt forKey:@"CurrentStudyInt"];
    [currentSettings setInteger:self.breakSliderInt forKey:@"CurrentBreakInt"];
    [currentSettings synchronize];

    NSLog(@"0 Current Age %ld", (long)self.age);
    NSLog(@"0 Current Gender %ld", (long)self.gender);
    NSLog(@"0 Current ADHD %ld", (long)self.ADHD);
    NSLog(@"0 Current Study %ld", (long)self.studySliderInt);
    NSLog(@"0 Current Break %ld", (long)self.breakSliderInt);


}



@end
