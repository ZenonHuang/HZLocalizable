//
//  HZLanguageViewController.h
//  HZLocalizable
//
//  Created by zz go on 2017/4/27.
//  Copyright © 2017年 zzgo. All rights reserved.
//
#import <UIKit/UIKit.h>


typedef void (^HZLanguageHandler)(NSString *result);

@interface  HZLanguageViewController : UIViewController

@property (nonatomic, readwrite, strong) NSArray<NSString *> *selectArray;

@property (nonatomic, copy) HZLanguageHandler selectedHandler;

-(void)setSelectedHandler:(HZLanguageHandler)selectedHandler;
@end

