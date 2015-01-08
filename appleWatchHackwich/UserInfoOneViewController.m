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
    UserInfoTwoViewController *pageTwo = [UserInfoTwoViewController new];

    self.genders = @[@"-",@"Male", @"Female"];
    self.ADHD = 0;
    self.pickGenderPicker.dataSource = self;
    self.pickGenderPicker.delegate = self;
    pageTwo.ADD = 0;
    pageTwo.Dys = 0;

    self.tapTohideKB = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:self.tapTohideKB];
    NSLog(@"The age %ld", (long)self.age);

}

-(void)viewWillDisappear:(BOOL)animated{
    [self passData];
}

-(void)hideKeyboard{
    [self.txtAge resignFirstResponder];
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

- (IBAction)onADHDSwitch:(UISwitch *)sender {
    if ([self.SwtchADHDSwitch isOn]) {
        [self.SwtchADHDSwitch setOn:YES animated:YES];
        self.ADHD = 1;
        NSLog(@"ADHD Switch is on %ld", (long)self.ADHD);
    } else {
        [self.SwtchADHDSwitch setOn:NO animated:YES];
        self.ADHD = 0;
        NSLog(@"ADHD Switch is off %ld", (long)self.ADHD);
    }
}


-(void)passData{
    self.age = [self.txtAge.text intValue];
    NSLog(@"%ld", (long)self.age);

    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];

    [currentSettings setInteger:self.age forKey:@"CurrentAge"];
    [currentSettings setInteger:self.gender forKey:@"CurrentGender"];
    [currentSettings setInteger:self.ADHD forKey:@"CurrentADHD"];

    [currentSettings synchronize];

    NSLog(@"Passing UI1VC Current Age %ld /n", (long)self.age);
    NSLog(@"Passing UI1VC Current Gender %ld", (long)self.gender);
    NSLog(@"Passing UI1VC Current ADHD %ld", (long)self.ADHD);
}

@end