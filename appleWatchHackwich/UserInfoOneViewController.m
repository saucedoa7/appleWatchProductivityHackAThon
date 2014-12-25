//
//  UserInfoViewController.m
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/6/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "UserInfoOneViewController.h"
#import "InterfaceController.h"

@interface UserInfoOneViewController ()<UIPickerViewDelegate, UIPickerViewDataSource, UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *genders;
@property (strong, nonatomic) NSArray *pageOneLabels;
@property (strong, nonatomic) NSArray *pageTwoLabels;
@property (strong, nonatomic) NSArray *pages;
@property (strong, nonatomic) NSArray *pageTitles;

@property NSInteger age;
@property NSInteger gender;
@property NSInteger ADHD;
@property NSUInteger pageIndex;

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

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

    self.pageOneLabels = @[self.lblAge, self.lblGender, self.lblADHD, self.txtAge, self.pickGenderPicker, self.SwtchADHDSwitch];
    self.pages = @[self.pageOneLabels, self.pageTwoLabels];

    [self.pageTwoLabels setValue:[NSNumber numberWithBool:YES] forKey:@"hidden"];

    self.genders = @[@"-",@"Male", @"Female"];
    self.ADHD = 0;
    self.pickGenderPicker.dataSource = self;
    self.pickGenderPicker.delegate = self;

    self.tapTohideKB = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:self.tapTohideKB];
    NSLog(@"%ld", (long)self.age);

    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];

    //[self.pageViewController setDelegate:self];
    [self.pageViewController setDataSource:self];

    UserInfoOneViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];

    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];

    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
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

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = ((UserInfoOneViewController *) viewController).pageIndex;

    if (index == NSNotFound) {
        return nil;
    }

    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = ((UserInfoOneViewController *) viewController).pageIndex;

    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }

    index--;
    return [self viewControllerAtIndex:index];
}

- (UserInfoOneViewController *)viewControllerAtIndex:(NSInteger)index{
    if ([self.pageTitles count] == 0 || index >= [self.pageTitles count]) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    UserInfoOneViewController *userInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserInfoOneViewController"];
    userInfoVC.pageOneLabels = self.pageOneLabels[index];
    //userInfoVC.pageTwoLabels = self.pageTwoLabels[index];
    userInfoVC.pageIndex = index;

    return userInfoVC;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
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