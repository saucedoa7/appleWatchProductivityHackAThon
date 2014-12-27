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
    /*  
     This is not how i implemented my pager xD

     is that good or bad?
     so you check the page number, and then you create 2 arrays with all the gui elements inside
     every view, and you hidde those elements depending on what page you are? yup
     this is very or super tricky... did you think that byyourself? yea
     its nice cause you learned stuff like awesome but its not the way you are supposed to do this
     you have to add a PageViewController, see
     and with this if you want to add inside this VC you neeed a Container, and the container will point to
     the pageviewer, and the pagevieweer creates a VC for every view, this is how i did it, one sec.
     fuck the scrolling doesnt work, anyway if you want swipe you cant do like this sorry

     I figured, SO i would have to us that paveViewController instead.. to get an animation
     im searching on my laptop if you can do with this way. 1 moment. ok
     I have to use the Bathroom, brb.
     To accomplish with this way you have to create your own views and transition between themm,
     plus you dont have swipe to transition bwteen pages, forget this way cause AutoLayout will get you stuck.
     enter my laptop and see how i did it, i close i give you id and pw in fb
     */

    self.genders = @[@"-",@"Male", @"Female"];
    self.ADHD = 0;
    self.pickGenderPicker.dataSource = self;
    self.pickGenderPicker.delegate = self;

    self.tapTohideKB = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:self.tapTohideKB];
    NSLog(@"%ld", (long)self.age);

}

/*
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
*/

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
@end