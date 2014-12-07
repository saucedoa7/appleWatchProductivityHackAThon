//
//  UserInfoViewController.m
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/6/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "UserInfoViewController.h"
#import "InterfaceController.h"

@interface UserInfoViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UIPickerView *pickGenderPicker;
@property (strong, nonatomic) IBOutlet UITextField *txtAge;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapTohideKB;
@property (strong, nonatomic) IBOutlet UISwitch *SwtchADHDSwitch;
@property NSArray *genders;


@end

@implementation UserInfoViewController

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

-(void)hideKeyboard{
    self.age = [self.txtAge.text intValue];
    NSLog(@"%ld", (long)self.age);
    [self.txtAge resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        self.gender = 0;
    } else if (row == 2) {
        NSLog(@"Picker row is Female");
        self.gender = 1;
    }
}

- (IBAction)onSwitch:(UISwitch *)sender {
    if ([self.SwtchADHDSwitch isOn]) {
        [self.SwtchADHDSwitch setOn:YES animated:YES];
        self.ADHD = 1;
        NSLog(@"Switch is on %ld", (long)self.ADHD);
    } else {
        [self.SwtchADHDSwitch setOn:NO animated:YES];
        self.ADHD = 0;
        NSLog(@"Switch is off %ld", (long)self.ADHD);
    }

}
- (IBAction)onDoneButtonPressed:(UIButton *)sender {
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    [currentSettings setInteger:self.age forKey:@"CurrentAge"];
    [currentSettings setInteger:self.gender forKey:@"CurrentGender"];
    [currentSettings setInteger:self.ADHD forKey:@"CurrentADHD"];
    [currentSettings synchronize];

    NSLog(@"0 Current Age %ld", (long)self.age);
    NSLog(@"0 Current Gender %ld", (long)self.gender);
    NSLog(@"0 Current ADHD %ld", (long)self.ADHD);
}


@end
