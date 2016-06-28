//
//  SettingViewController.m
//  SwitchLanguage
//
//  Created by apple on 2016/6/28.
//  Copyright © 2016年 New Idea. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self reloadUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadUI) name:kAppLanguageDidChange object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadUI{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *data = [[LanguageManager shareInstance] getAppConfigLanguages];
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell1"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingCell1"];
    }
    NSString *language = [[[LanguageManager shareInstance] getAppConfigLanguages] objectAtIndex:indexPath.row];
    cell.textLabel.text = language;
    if ([language isEqualToString:[[LanguageManager shareInstance] getCurrentLanguage]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%@",LMLocalizedString(@"Setting Language", nil)];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%@:%@",LMLocalizedString(@"Current Language", nil),[[LanguageManager shareInstance] getCurrentLanguage]];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [SVProgressHUD showWithStatus:LMLocalizedString(@"Setting Language...", nil)];
    [[LanguageManager shareInstance] setAppLanguageWithLanguageIndex:indexPath.row complete:^(BOOL success) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:nil];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
