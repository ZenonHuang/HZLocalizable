//
//  HZMacro.h
//  QLiveStream
//
//  Created by quseit02 on 16/7/28.
//  Copyright © 2016年 quseit. All rights reserved.
//

#import "HZLanguageManager.h"

//程序的本地化,引用国际化的文件
//#define HZLocal(x, ...) \
//    [NSBundle.mainBundle localizedStringForKey:(x) value:@"" table:nil]


#define HZLocal(x, ...) \
HZLocalizedString(x, nil)
//NSLocalizedString(x, nil)




