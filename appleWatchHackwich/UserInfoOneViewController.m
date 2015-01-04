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

@interface UserInfoOneViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation UserInfoOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.genders = @[@"-",@"Male", @"Female"];
    self.ADHD = 0;
    self.pickGenderPicker.dataSource = self;
    self.pickGenderPicker.delegate = self;

    self.tapTohideKB = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:self.tapTohideKB];
    NSLog(@"%ld", (long)self.age);

}

-(void)viewWillDisappear:(BOOL)animated{
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    [currentSettings setInteger:self.ADD forKey:@"CurrentFromUserInfoOneVCADD"];
    NSLog(@"UI1VC Current ADD %ld", (long)self.ADD);

    [currentSettings setInteger:self.dyslexia forKey:@"CurrentFromUserInfoOneDys"];
    NSLog(@"UI1VC Current Dys %ld", (long)self.dyslexia);
}

-(void)hideKeyboard{
    self.age = [self.txtAge.text intValue];
    NSLog(@"%ld", (long)self.age);
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
    NSLog(@"Picker row %ld", (long)row);

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

- (IBAction)onADDSwitch:(UISwitch *)sender {
    if ([self.switchADDSwitch isOn]) {
        [self.switchADDSwitch setOn:YES animated:YES];
        self.ADD = 1;
        NSLog(@"ADD Switch is on %ld", (long)self.ADD);
    } else {
        [self.switchADDSwitch setOn:NO animated:YES];
        self.ADD = 0;
        NSLog(@"ADD Switch is off %ld", (long)self.ADD);
    }


}

- (IBAction)onDyslexiaSwitch:(UISwitch *)sender {
    if ([self.switchDyslexiaSwitch isOn]) {
        [self.switchDyslexiaSwitch setOn:YES animated:YES];
        self.dyslexia = 1;
        NSLog(@"dyslexia Switch is on %ld", (long)self.dyslexia);
    } else {
        [self.switchDyslexiaSwitch setOn:NO animated:YES];
        self.dyslexia = 0;
        NSLog(@"dyslexia Switch is off %ld", (long)self.dyslexia);
    }
}

@end