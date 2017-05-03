//
//  LanguageControl.h
//  Language
//
//  Created by lawrence on 17/4/26.
//  Copyright © 2017年 李辉. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHINESE @"zh-Hans"
#define ENGLISH @"en"

#define  LanString(s_key) [[[LanguageControl shareInstance] bundle] localizedStringForKey:s_key value:nil table:nil]

typedef void (^ChangeSuccessBlock)();
@interface LanguageControl : NSObject

+ (id)shareInstance;

- (NSBundle *)bundle;//获取当前资源文件

- (void)setUserlanguage:(NSString *)language success:(ChangeSuccessBlock)block;//设置当前语言

- (NSString*)print:(NSString *)firstArg, ... NS_REQUIRES_NIL_TERMINATION;
@end
