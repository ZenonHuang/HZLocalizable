//
//  HZLanguageManager.h
//  HZLocalizable
//
//  Created by zz go on 2017/4/27.
//  Copyright © 2017年 zzgo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HZLocalizedString(key, comment)               HZLocalizedStringFromTable(key, @"Localizable", nil)
#define HZLocalizedStringFromTable(key, tbl, comment) [[HZLanguageManager defaultManager] stringWithKey:key table:tbl]

static NSString * const kNoticeLanguageChange = @"kNoticeLanguageChange";


typedef NS_ENUM(NSUInteger, HZLanguageType) {
    HZLanguageTypeSystem,
    HZLanguageTypeEnglish,
    HZLanguageTypeChineseSimple,
};

@interface HZLanguageManager : NSObject

@property (nonatomic, assign, getter=currentLanguageType) HZLanguageType languageType;

+ (instancetype)defaultManager;

- (void)changeLanguageType:(HZLanguageType)type;
- (NSString *)stringWithKey:(NSString *)key table:(NSString *)table;
-(HZLanguageType)currentLanguage;

@end
