



#import "HZLanguageManager.h"

//程序的本地化,引用国际化的文件
//#define HZLocal(x, ...) \
//    [NSBundle.mainBundle localizedStringForKey:(x) value:@"" table:nil]


#define HZLocal(x, ...) \
HZLocalizedString(x, nil)
//NSLocalizedString(x, nil)




