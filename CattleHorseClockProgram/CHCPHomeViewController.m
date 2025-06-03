//
//  CHCPHomeViewController.m
//  CattleHorseClockProgram
//
//  Created by runingfish on 2025/6/3.
//

#import "CHCPHomeViewController.h"

@interface CHCPHomeViewController ()

@end

@implementation CHCPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MAIN_VIEW_COLOR;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,90, [UIScreen mainScreen].bounds.size.width-40, 60)];
    [self.view addSubview:titleLabel];
    titleLabel.text = @"账号管理助手";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30];
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
