//
//  UserInfoViewController.m
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/6/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "UserInfoOneViewController.h"
#import "InterfaceController.h"
#import "AddInfoViewController.h"
#import "UserInfoTwoViewController.h"

@interface UserInfoOneViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation UserInfoOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.genders = @[@"-",@"Male", @"Female"];
    self.pickGenderPicker.dataSource = self;
    self.pickGenderPicker.delegate = self;

    self.tapTohideKB = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:self.tapTohideKB];
    NSLog(@"The age %ld", (long)self.age);
}

-(void)viewWillDisappear:(BOOL)animated{
    [self GetData];

    if (self.studyTime == !0 || self.breakTime == !0) {
        self.txtAge.text = @"0";
        self.age = 0;
    }
}

-(void)hideKeyboard{

    self.age = [self.txtAge.text intValue];
    NSLog(@"Age %ld", (long)self.age);

    if (self.studySliderInt == !0 && self.age == 0) {
        self.studySliderInt = 0;
    }

    [self.txtAge resignFirstResponder];
    [self.txtSleep resignFirstResponder];

    [self storeData];
    // Use this when swiping thru pages and hiding previous labels
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.genders.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.genders[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (row == 1) {
        NSLog(@"Picker row is Male");
        self.gender = 1;
    } else if (row == 2) {
        NSLog(@"Picker row is Female");
        self.gender = 2;
    } else if (row == 0){
        NSLog(@"Picker row is - ");
        self.gender = 0;
    }
}

-(void)GetData{

#pragma mark Get Data from other VC's

    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    NSInteger newAge = [currentSettings integerForKey:@"CurrentAge"];
    NSInteger newGender = [currentSettings integerForKey:@"CurrentGender"];
    NSInteger newADHD = [currentSettings integerForKey:@"CurrentADHD"];
    NSInteger newADD = [currentSettings integerForKey:@"CurrentADD"];
    NSInteger newDys = [currentSettings integerForKey:@"CurrentDys"];
    NSInteger newStudyInt = [currentSettings integerForKey:@"CurrentStudyInt"];
    NSInteger newBreakInt = [currentSettings integerForKey:@"CurrentBreakInt"];

    self.age = newAge;
    self.gender = newGender;
    self.ADHD = newADHD;

    self.studyTime = newStudyInt;
    self.breakTime = newBreakInt;

    NSLog(@"Getting data for UI1VC Current age %ld /n", (long)self.age);
    NSLog(@"Getting data for UI1VC Current gender %ld", (long)self.gender);
    NSLog(@"Getting data for UI1VC Current ADHD %ld", (long)self.ADHD);

    NSLog(@"Getting data for UI1VC Current Study Time %ld", (long)self.studyTime);
    NSLog(@"Getting data for UI1VC Current Break Time %ld", (long)self.breakTime);
}

-(void)storeData{


    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];

    [currentSettings setInteger:self.age forKey:@"CurrentAge"];
    [currentSettings setInteger:self.gender forKey:@"CurrentGender"];

    [currentSettings synchronize];

    NSLog(@"Passing UI1VC Current Age %ld /n", (long)self.age);
    NSLog(@"Passing UI1VC Current Gender %ld", (long)self.gender);
}
- (IBAction)onClear:(UIButton *)sender {
    self.txtAge.text = @"0";
    NSLog(@"Clear button");
}

@end