//
//  LanguageControl.m
//  Language
//
//  Created by lawrence on 17/4/26.
//  Copyright © 2017年 李辉. All rights reserved.
//

#import "LanguageControl.h"
static NSString *Lan_key = @"userLanguageKey";
@implementation LanguageControl

static NSBundle *bundle = nil;
static LanguageControl *sharedModel = nil;
+ (id)shareInstance{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModel = [[LanguageControl alloc] init];
    });
    
    return sharedModel;
}

- (NSBundle *)bundle{
    return bundle;
}

- (id)init{

    if (self = [super init]) {
        
        [self initUserLanguage];
    }
    
    return self;
}

- (void)initUserLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *string = [def valueForKey:Lan_key];
    if(string.length == 0){
        
        //获取系统当前语言版本(中文zh-Hans,英文en)
        NSArray* languages = [def objectForKey:@"AppleLanguages"];
        NSString *current = [languages objectAtIndex:0];
        string = current;
        [def setValue:current forKey:Lan_key];
        [def synchronize];
    }
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];//生成bundle
 
}


- (void)setUserlanguage:(NSString *)language success:(ChangeSuccessBlock)block{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    //1.第一步改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    bundle = [NSBundle bundleWithPath:path];
    //2.持久化
    [def setValue:language forKey:Lan_key];
    [def synchronize];
    
    if (block) {
        block();
    }
}


- (NSString*)print:(NSString *)firstArg, ... NS_REQUIRES_NIL_TERMINATION {
    
    if (firstArg) {
        // 取出第一个参数
        NSString *baseStr = [[[LanguageControl shareInstance] bundle] localizedStringForKey:firstArg value:@"" table:nil];
        NSLog(@"%@", firstArg);
        // 定义一个指向个数可变的参数列表指针；
        va_list args;
        // 用于存放取出的参数
        NSString *arg;
        // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
        va_start(args, firstArg);
        // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
        
        while ((arg = va_arg(args, NSString *))) {
            NSLog(@"%@", arg);
            baseStr = [NSString stringWithFormat:baseStr,arg];
            
        }
        // 清空参数列表，并置参数指针args无效
        va_end(args);
        
        return baseStr;
    }
    
    
    return @"";
}

@end
