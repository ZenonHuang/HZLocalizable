//
//  ViewController.m
//  HZLocalizable
//
//  Created by zz go on 2017/4/27.
//  Copyright © 2017年 zzgo. All rights reserved.
//


#import "ViewController.h"
#import "HZMacro.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.languageLabel.text=HZLocal(@"hello,world!");
    [self.nextButton setTitle:HZLocal(@"Next") forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
