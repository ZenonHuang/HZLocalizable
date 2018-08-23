//
//  HZLanguageManager.m
//  HZLocalizable
//
//  Created by zz go on 2017/4/27.
//  Copyright © 2017年 zzgo. All rights reserved.
//

#import "HZLanguageManager.h"

static NSString * const kSystem      = @"SystemDefault";

static NSString * const kCH          = @"zh-Hans";
static NSString * const kEN          = @"en";


static NSString * const kProj        = @"lproj";
static NSString * const kLanguageSet = @"kLanguageSet";

@interface HZLanguageManager()

@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) NSString *languageString;

@end

@implementation HZLanguageManager

+ (instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    static HZLanguageManager *manager;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[HZLanguageManager alloc] init];
        }
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    //取字段看是哪种语言
    NSString *tempStr = [[NSUserDefaults standardUserDefaults] objectForKey:kLanguageSet];
    //    NSString *path;
    
    //假如用户没有设置过语言
    if (!tempStr) {
        tempStr=kSystem;
    }
    
    self.languageString = tempStr;
    
    
    if ([self.languageString isEqualToString:kCH]) {//为中文
        
        self.languageType = HZLanguageTypeChineseSimple;
        
    }else if ([self.languageString isEqualToString:kEN]) {//为英文
        
        self.languageType = HZLanguageTypeEnglish;
        
    }else if([self.languageString isEqualToString:kSystem]){//为系统默认
        
        self.languageType= HZLanguageTypeSystem;
    }
    
    if ([_languageString isEqualToString:kEN] || [_languageString isEqualToString:kCH]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:_languageString ofType:kProj];
        self.bundle = [NSBundle bundleWithPath:path];
    }
    
    return self;
}



- (void)changeLanguageType:(HZLanguageType)type;
{
    if (self.currentLanguageType == type) {
        return;
    }
    
    _languageType = type;
    switch (type) {
        case HZLanguageTypeSystem:
            
            self.languageString=kSystem;
            break;
        case HZLanguageTypeEnglish:
            
            self.languageString = kEN;
            break;
        case HZLanguageTypeChineseSimple:
            
            self.languageString = kCH;
            break;

    }
    
    //bundle 设置
    [self resetBundle];
    
    //设置语言，并作记录保存
    [[NSUserDefaults standardUserDefaults] setObject:_languageString forKey:kLanguageSet];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //使用通知更改文字    [[NSNotificationCenter defaultCenter] postNotificationName:kNoticeLanguageChange object:nil];
}

- (void)resetBundle{
    if ([_languageString isEqualToString:kEN] || [_languageString isEqualToString:kCH]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:_languageString ofType:kProj];
        self.bundle = [NSBundle bundleWithPath:path];
    }
}

- (NSString *)stringWithKey:(NSString *)key table:(NSString *)table
{
    //假如为跟随系统
    if (self.languageType==HZLanguageTypeSystem) {
        return  NSLocalizedString(key, nil);
    }
    
    //返回对应国际化文字
    if (_bundle) {
        return  NSLocalizedStringFromTableInBundle(key, table, _bundle, nil);
    }
    
    return NSLocalizedStringFromTable(key, table, nil);
}

-(HZLanguageType)currentLanguage{
    //获取当前语言
    //  NSString *tempStr = [[NSUserDefaults standardUserDefaults] objectForKey:kLanguageSet];
    //    if ([tempStr rangeOfString:@"zh"].length) {
    ////        tempStr = kCH;
    //        return HZLanguageTypeChineseSimple;
    //    }else if([tempStr isEqualToString:kEN]){
    ////        tempStr = kEN;
    //        return HZLanguageTypeEnglish;
    //    }else {//if([tempStr isEqualToString:kSystem])
    //    
    //        return HZLanguageTypeSystem;
    //    }
    return    self.languageType;
}

@end
