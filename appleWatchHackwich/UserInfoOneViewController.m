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
    [self GetData];

    self.genders = @[@"-",@"Male", @"Female"];
    self.pickGenderPicker.dataSource = self;
    self.pickGenderPicker.delegate = self;

    self.tapTohideKB = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:self.tapTohideKB];
    NSLog(@"The age %ld", (long)self.age);


    self.txtAge.text = [NSString stringWithFormat:@"%ld", self.age];
    [self.pickGenderPicker selectRow:self.gender inComponent:0 animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"US1VC view will appear");

    [self GetData];

    if (self.studySliderInt == !0 || self.breakSliderInt == !0 ) {
        [self resetSliderInts];
    }

    [self storeData];
}

-(void)resetSliderInts{
    self.studySliderInt = 0;
    self.breakSliderInt = 0;
}

-(void)viewWillDisappear:(BOOL)animated{
    //to Override


    NSLog(@"UI1VC VIEW WILL DISAPP");

    //[self GetData]; //

    if ([self.txtAge.text isEqualToString:@""]) {
        self.txtAge.text = @"0";
        self.age = 0;
    }

    //self.age = [self.txtAge.text intValue];

    NSLog(@"Age %ld", (long)self.age);
    NSLog(@"Gender %ld", (long)self.gender);

    if (self.studySliderInt == !0 && self.breakSliderInt == 0) {
        self.studySliderInt = 0;
        NSLog(@"First if UI1VC");
        [self storeData];

    }

    if (self.studyTime == !0 || self.breakTime == !0) {
        self.txtAge.text = @"0";
        self.age = 0;
        NSLog(@"second if UI1VC");
        [self storeData];
    }
    NSLog(@"NO if UI1VC");
    
    [self storeData];
}

-(void)hideKeyboard{

    if ([self.txtAge.text isEqualToString:@""]) {
        self.txtAge.text = @"0";
        self.age = 0;
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
    [self storeData];
}

-(void)GetData{

#pragma mark Get Data from other VC's

    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    NSInteger newAge = [currentSettings integerForKey:@"CurrentAge"];
    NSInteger newGender = [currentSettings integerForKey:@"CurrentGender"];
    NSInteger newADHD = [currentSettings integerForKey:@"CurrentADHD"];
    NSInteger newADD = [currentSettings integerForKey:@"CurrentADD"];
    NSInteger newDys = [currentSettings integerForKey:@"CurrentDys"];

    NSInteger newStudy = [currentSettings integerForKey:@"CurrentStudyTime"];
    NSInteger newBreak = [currentSettings integerForKey:@"CurrentBreakTime"];

    self.age = newAge;
    self.gender = newGender;
    self.ADHD = newADHD;
    self.ADD = newADD;
    self.Dys = newDys;

    self.studySliderInt = newStudy;
    self.breakSliderInt = newBreak;

    self.studyTime = self.studySliderInt;
    self.breakTime = self.breakSliderInt;

    NSLog(@"\nGetting data for UI1VC Current Age %ld, Gender %ld, ADHD %ld, ADD %ld, Dys %ld, StudyInt %ld, BreakInt %ld, Study %ld ,Break %ld",(long)self.age,(long)self.gender,(long)self.ADHD,(long)self.ADD,(long)self.Dys,(long)self.studySliderInt,(long)self.breakSliderInt,(long)self.studyTime,(long)self.breakTime);
}

-(void)storeData{

    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];

    [currentSettings setInteger:self.age forKey:@"CurrentAge"];
    [currentSettings setInteger:self.gender forKey:@"CurrentGender"];

    [currentSettings synchronize];

    NSLog(@"\nStoring UI1VC Current Age %ld, Gender %ld, ADHD %ld, ADD %ld, Dys %ld, StudyInt %ld, BreakInt %ld, Study %ld ,Break %ld",(long)self.age,(long)self.gender,(long)self.ADHD,(long)self.ADD,(long)self.Dys,(long)self.studySliderInt,(long)self.breakSliderInt,(long)self.studyTime,(long)self.breakTime);
}
- (IBAction)onClear:(UIButton *)sender {
    self.txtAge.text = @"0";
    NSLog(@"Clear button");
}

@end