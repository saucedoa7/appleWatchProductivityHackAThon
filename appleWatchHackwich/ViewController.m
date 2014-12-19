//
//  ViewController.m
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/6/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "ViewController.h"
#import "PageContentViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.pageTitles = @[@"Over 200 Tips", @"Discover Hidden Features", @"Bookmark favorite tip", @"Free Regualr update"];
    self.pageImages = @[@"page1.png", @"page2.png", @"page3.png", @"page4.png"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)unWindToMainVC:(UIStoryboardSegue *)sender{

}
- (IBAction)btnStartAgain:(UIButton *)sender {
}
- (IBAction)btnStartWalkThrough:(UIButton *)sender {
}
@end
