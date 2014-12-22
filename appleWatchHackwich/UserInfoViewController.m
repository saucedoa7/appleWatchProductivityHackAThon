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
@property (strong, nonatomic) IBOutlet UISlider *sldStudySlider;
@property (strong, nonatomic) IBOutlet UISlider *sldBreakSlider;
@property (strong, nonatomic) IBOutlet UILabel *lblStudyTime;
@property (strong, nonatomic) IBOutlet UILabel *lblBreakTime;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblADHD;
@property (weak, nonatomic) IBOutlet UIView *currentView;
@property (weak, nonatomic) IBOutlet UILabel *lblTest2;

@property (strong, nonatomic) NSArray *genders;
@property (strong, nonatomic) NSArray *pageOneLabels;
@property (strong, nonatomic) NSArray *pageTwoLabels;
@property (strong, nonatomic) NSArray *pages;

@property NSInteger age;
@property NSInteger gender;
@property NSInteger ADHD;
@property NSInteger studySliderInt;
@property NSInteger breakSliderInt;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // This is not how i implemented my pager xD

    //is that good or bad?
    // so you check the page number, and then you create 2 arrays with all the gui elements inside
    // every view, and you hidde those elements depending on what page you are? yup
    //this is very or super tricky... did you think that byyourself? yea
    // its nice cause you learned stuff like awesome but its not the way you are supposed to do this
    //you have to add a PageViewController, see
    // and with this if you want to add inside this VC you neeed a Container, and the container will point to
    // the pageviewer, and the pagevieweer creates a VC for every view, this is how i did it, one sec.
    // fuck the scrolling doesnt work, anyway if you want swipe you cant do like this sorry

    // I figured, SO i would have to us that paveViewController instead.. to get an animation
    // im searching on my laptop if you can do with this way. 1 moment. ok
    //I have to use the Bathroom, brb.
    //To accomplish with this way you have to create your own views and transition between themm,
    //plus you dont have swipe to transition bwteen pages, forget this way cause AutoLayout will get you stuck.
    //enter my laptop and see how i did it, i close i give you id and pw in fb

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

    self.studySliderInt = 0;
    self.breakSliderInt = 0;

    NSLog(@"1st %ld", (long)self.studySliderInt);
    NSLog(@"1st %ld", (long)self.breakSliderInt);

    self.pageOneLabels = @[self.lblAge, self.lblGender, self.lblADHD, self.txtAge, self.pickGenderPicker, self.SwtchADHDSwitch];
    self.pageTwoLabels = @[self.lblTest2];
    self.pages = @[self.pageOneLabels, self.pageTwoLabels];

    [self.pageTwoLabels setValue:[NSNumber numberWithBool:YES] forKey:@"hidden"]; //this is awesome

    self.genders = @[@"-",@"Male", @"Female"];
    self.ADHD = 0;
    self.pickGenderPicker.dataSource = self;
    self.pickGenderPicker.delegate = self;

    self.tapTohideKB = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:self.tapTohideKB];
    NSLog(@"%ld", (long)self.age);
}

- (IBAction)pageControllerChanged:(id)sender {

    NSInteger selectPage = [self.pageControl currentPage];
    NSLog(@"NSINT %ld", (long)selectPage);
    self.currentView = self.pages [selectPage];

    if (selectPage == 0) {
        [self.pageOneLabels setValue:[NSNumber numberWithBool:NO] forKey:@"hidden"];
        [self.pageTwoLabels setValue:[NSNumber numberWithBool:YES] forKey:@"hidden"];
    } else if (selectPage == 1) {
        [self.pageTwoLabels setValue:[NSNumber numberWithBool:NO] forKey:@"hidden"];
        [self.pageOneLabels setValue:[NSNumber numberWithBool:YES] forKey:@"hidden"];
    }
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

- (IBAction)onStudySlide:(UISlider *)sender {
    self.lblStudyTime.text =[[NSString alloc] initWithFormat:@"%.0fm", self.sldStudySlider.value];
    self.studySliderInt = self.sldStudySlider.value;
    self.txtAge.text = @"0";
    [self.SwtchADHDSwitch setOn:NO animated:YES];
    [self.pickGenderPicker selectRow:0 inComponent:0 animated:YES];
}
- (IBAction)onBreakTime:(UISlider *)sender {
    self.lblBreakTime.text = [[NSString alloc] initWithFormat:@"%.0fm", self.sldBreakSlider.value];
    self.breakSliderInt = self.sldBreakSlider.value;
    [self.SwtchADHDSwitch setOn:NO animated:YES];
    [self.pickGenderPicker selectRow:0 inComponent:0 animated:YES];
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
        self.studySliderInt = 60;
        self.breakSliderInt = 15;
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