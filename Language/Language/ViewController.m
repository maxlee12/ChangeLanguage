//
//  ViewController.m
//  Language
//
//  Created by lawrence on 17/4/26.
//  Copyright © 2017年 李辉. All rights reserved.
//

#import "ViewController.h"
#import "LanguageControl.h"
#import "AppDelegate.h"
@interface ViewController ()
{
    __weak IBOutlet UIButton* changeEnBtn;
    
    __weak IBOutlet UIButton* changeCnBtn;
    
    __weak IBOutlet UILabel *lab1;
    __weak IBOutlet UILabel *lab2;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [changeEnBtn setTitle:LanString(@"changeEn") forState:UIControlStateNormal];
    
    [changeCnBtn setTitle:LanString(@"changeCn") forState:UIControlStateNormal];
    
    lab1.text = LanString(@"chinese");
    
    lab2.text = LanString(@"english");
}

/** 切换语言 */
- (IBAction)changeChinese:(id)sender{
    
    [[LanguageControl shareInstance] setUserlanguage:CHINESE success:^{
        [self reopenApp];
    }];
}

- (IBAction)changeEnglish:(id)sender{

    [[LanguageControl shareInstance] setUserlanguage:ENGLISH success:^{
        [self reopenApp];
    }];

}

/** 刷新App */
- (void)reopenApp{

    //可以做App重启操作，比如 跳转到欢迎页面重新启动
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setRootLogInViewController];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
