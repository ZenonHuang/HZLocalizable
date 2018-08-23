//
//  HZLanguageViewController.m
//  HZLocalizable
//
//  Created by zz go on 2017/4/27.
//  Copyright © 2017年 zzgo. All rights reserved.
//

#import "HZLanguageViewController.h"
#import "HZMacro.h"



static NSString *normalCellIdentifier=@"normalCellTableIdentifier";

static NSString *SeletedCellProfileCellIdentifier=@"SelectedCellProfileCellTableIdentifier";

@interface HZLanguageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,readwrite,strong) UITableView *tableView;
@property (nonatomic,readwrite,strong) NSNumber   *seletedIndex;

@property (nonatomic,readwrite,strong) id result;
@end

@implementation HZLanguageViewController

#pragma mark - life cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
   
    self.selectArray=@[HZLocal(@"Follow the system"),@"中文",@"English"];
    
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backButton setTitle:HZLocal(@"Back") forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    //设置选中的语言
    if ([HZLanguageManager defaultManager].currentLanguage==HZLanguageTypeSystem) {
        self.seletedIndex=@0;
    }
    if ([HZLanguageManager defaultManager].currentLanguage==HZLanguageTypeChineseSimple) {
        self.seletedIndex=@1;
    }
    if ([HZLanguageManager defaultManager].currentLanguage==HZLanguageTypeEnglish) {
        self.seletedIndex=@2;
    }
    
    [self.view addSubview:self.tableView];
}

- (void)backItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - response events
-(void)onRightNavButtonTapped:(UIBarButtonItem *)sender event:(UIEvent *)event{
    
    !self.selectedHandler?:self.selectedHandler([self.result copy]);
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =  [tableView cellForRowAtIndexPath:indexPath];
    
    self.result= cell.textLabel.text;
    self.seletedIndex=[NSNumber numberWithInteger:indexPath.row];
    
    //选择更改语言设置
    if (indexPath.row==0) {
        [[HZLanguageManager defaultManager] changeLanguageType: HZLanguageTypeSystem];
    }
    if (indexPath.row==1) {
        [[HZLanguageManager defaultManager] changeLanguageType: HZLanguageTypeChineseSimple];
    }
    if (indexPath.row==2) {
        [[HZLanguageManager defaultManager] changeLanguageType: HZLanguageTypeEnglish];
    }
    
    //销毁 root
     UIWindow *oldWindow=[UIApplication sharedApplication].keyWindow;
     oldWindow.rootViewController=nil;
    
    //新 root
    UIWindow *newWindow = [UIApplication sharedApplication].keyWindow;
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *navVC = [story instantiateViewControllerWithIdentifier:@"navVC"];   
    newWindow.rootViewController=navVC;
    
   //重新 push
    HZLanguageViewController *languageVC=[HZLanguageViewController new];
    [navVC pushViewController:languageVC animated:NO];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *itemString = self.selectArray[indexPath.row];
    
    
    if ([self.seletedIndex isEqualToNumber:[NSNumber numberWithInteger:indexPath.row]]) {
        UITableViewCell  * seletedCell=[tableView dequeueReusableCellWithIdentifier:SeletedCellProfileCellIdentifier
                                                                       forIndexPath:indexPath];
        seletedCell.accessoryType=UITableViewCellAccessoryCheckmark;
        seletedCell.textLabel.text=itemString;
        return seletedCell;
    }else{
        UITableViewCell  * cell=[tableView dequeueReusableCellWithIdentifier:normalCellIdentifier
                                                                forIndexPath:indexPath];
        cell.textLabel.text=itemString;
        return cell;
    }
    
}

#pragma mark - setter/getter
-(void)setSelectedHandler:(HZLanguageHandler)selectedHandler{
    _selectedHandler = selectedHandler;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        
        [_tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:normalCellIdentifier];
        [_tableView registerClass:[UITableViewCell class] 
           forCellReuseIdentifier:SeletedCellProfileCellIdentifier];
        
        _tableView.rowHeight=44;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
        //去除footer底下横线
        _tableView.tableFooterView=[UIView new];
        
    }
    return _tableView;
}


@end
