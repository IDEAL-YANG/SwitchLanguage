//
//  LanguageManager.h
//  SwitchLanguage
//
//  Created by apple on 2016/6/28.
//  Copyright © 2016年 New Idea. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LMLocalizedString(key,comment) \
[[LanguageManager shareInstance] internationalizedStringForKey:(key) value:@""]

extern NSString *const kAppLanguageDidChange;

typedef void(^SettingLanguageSuccess)(BOOL success);

@interface LanguageManager : NSObject

+ (instancetype)shareInstance;

- (NSString *)internationalizedStringForKey:(NSString *)key value:(NSString *)value;

- (NSString *)getCurrentLanguage;

- (NSArray *)getAppConfigLanguages;

- (void)setAppLanguageWithLanguageIndex:(NSInteger)index complete:(SettingLanguageSuccess)complete;

@end
