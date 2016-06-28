//
//  SecondViewController.m
//  SwitchLanguage
//
//  Created by apple on 2016/6/28.
//  Copyright © 2016年 New Idea. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UILabel *secondViewLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingBBI;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self reloadUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadUI) name:kAppLanguageDidChange object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadUI{
    self.secondViewLabel.text = LMLocalizedString(@"Second View", nil);
    self.settingBBI.title = LMLocalizedString(@"Setting", nil);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ShowSettingView"]) {
        UIViewController *vc = [segue destinationViewController];
        vc.hidesBottomBarWhenPushed = YES;
    }
}

@end
