//
//  LanguageManager.m
//  SwitchLanguage
//
//  Created by apple on 2016/6/28.
//  Copyright © 2016年 New Idea. All rights reserved.
//

#import "LanguageManager.h"

NSString *const appLanguageKey = @"APP_LANGUAGE_KEY";

NSString *const kAppLanguageDidChange = @"kAppLanguageDidChange";

static LanguageManager *instance;

@interface LanguageManager ()

@property (nonatomic, strong) NSBundle *currentBundle;
@property (nonatomic, strong) NSArray *languages;

@end

@implementation LanguageManager

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LanguageManager alloc] init];
    });
    return instance;
}

- (NSString *)internationalizedStringForKey:(NSString *)key value:(nullable NSString *)value{
    return [self.currentBundle localizedStringForKey:key value:@"" table:nil];
}

- (NSString *)getCurrentLanguage{
    return [self currentLanguage];
}

- (NSArray *)getAppConfigLanguages{
    return self.languages;
}

- (void)setAppLanguageWithLanguageIndex:(NSInteger)index complete:(SettingLanguageSuccess)complete{
    NSAssert(index < self.languages.count, @"Please check pre-setting languages array");
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:appLanguageKey];
    if (![language isEqualToString:self.languages[index]]) {
        NSLog(@"---new language:%@",self.languages[index]);
        [[NSUserDefaults standardUserDefaults] setObject:self.languages[index] forKey:appLanguageKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kAppLanguageDidChange object:nil];
            if (complete) {
                complete(YES);
            }
        });
    }
}

#pragma mark - private

- (NSBundle *)currentBundle{
    _currentBundle = [NSBundle bundleWithPath:[self bundlePath]];
    return _currentBundle;
}

- (NSString *)bundlePath{
    NSString *path = [[NSBundle mainBundle] pathForResource:[self currentLanguage] ofType:@"lproj"];
    return path;
}

- (NSString *)currentLanguage{
    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] firstObject];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:appLanguageKey] && ![[[NSUserDefaults standardUserDefaults] objectForKey:appLanguageKey] isEqualToString:language]) {
        language = [[NSUserDefaults standardUserDefaults] objectForKey:appLanguageKey];
    }
    return language;
}

- (NSArray *)languages{
    if (!_languages) {
        _languages = @[@"en", @"zh-Hans"];
    }
    return _languages;
}

@end
