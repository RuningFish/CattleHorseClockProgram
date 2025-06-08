//
//  CHCPRecordViewController.m
//  CattleHorseClockProgram
//
//  Created by runingfish on 2025/6/3.
//

#import "CHCPRecordViewController.h"
#import "CHCPRecordTableViewCell.h"
@interface CHCPRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *chcp_record_tableView;
@property (nonatomic, strong) NSMutableArray *chcp_record_dataSource;
@end

@implementation CHCPRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    [self chcp_record_setupUI];
    [self chcp_record_initData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chcp_record_initData) name:KCattleHorseClockRecordAddSuccessNotificationName object:nil];
}

- (void)chcp_record_setupUI {
    self.chcp_record_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.chcp_record_tableView];
    self.chcp_record_tableView.delegate = self;
    self.chcp_record_tableView.dataSource = self;
    self.chcp_record_tableView.rowHeight = UITableViewAutomaticDimension;
    self.chcp_record_tableView.estimatedRowHeight = 200;
    self.chcp_record_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chcp_record_tableView.backgroundColor = [UIColor clearColor];
}

- (void)chcp_record_initData{
    self.chcp_record_dataSource = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:KCattleHorseClockRecordPath]];
    [self initTableHeaderView];
    [self.chcp_record_tableView reloadData];
}

- (void)initTableHeaderView{
    if (self.chcp_record_dataSource.count == 0) {
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
        
        UILabel *nullDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,130, [UIScreen mainScreen].bounds.size.width-40, 100)];
        [tableHeaderView addSubview:nullDataLabel];
        nullDataLabel.text = @"还没有任何记录哦～";
        nullDataLabel.textColor = [UIColor systemOrangeColor];
        nullDataLabel.textAlignment = NSTextAlignmentCenter;
        nullDataLabel.font = [UIFont systemFontOfSize:20];
        
        self.chcp_record_tableView.tableHeaderView = tableHeaderView;
    }
    else{
        self.chcp_record_tableView.tableHeaderView = nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chcp_record_dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CHCPRecordTableViewCell *cell = [CHCPRecordTableViewCell cellWithTableView:tableView];
    if (indexPath.row < self.chcp_record_dataSource.count) {
        NSDictionary *dict = self.chcp_record_dataSource[indexPath.row];
        cell.dict = dict;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.chcp_record_dataSource.count) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                                 message:@"确定要删除该记录吗？"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSDictionary *dict = self.chcp_record_dataSource[indexPath.row];
            [self.chcp_record_dataSource removeObject:dict];
            [NSKeyedArchiver archiveRootObject:self.chcp_record_dataSource toFile:KCattleHorseClockRecordPath];
            [self.chcp_record_tableView reloadData];
            [self initTableHeaderView];
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:sureAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
