//
//  FirstViewController.m
//  SwitchLanguage
//
//  Created by apple on 2016/6/28.
//  Copyright © 2016年 New Idea. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *firstViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation FirstViewController

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
    self.firstViewLabel.text = LMLocalizedString(@"First View", nil);
    self.descLabel.text = LMLocalizedString(@"First Description", nil);
}

@end
