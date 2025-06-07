//
//  CHCPHomeViewController.m
//  CattleHorseClockProgram
//
//  Created by runingfish on 2025/6/3.
//

#import "CHCPHomeViewController.h"
#import "CHCPHomeCountdownView.h"
@interface CHCPHomeViewController ()<UITextFieldDelegate, UIScrollViewDelegate>
@property (nonatomic, copy) NSArray *chcp_home_item_list;
@property (nonatomic, strong) NSMutableArray *chcp_home_item_textField_list;
@property (nonatomic, assign) BOOL chcp_start_calculate;
@property (nonatomic, strong) UIScrollView *chcp_home_scrollView;
@property (nonatomic, strong) UIView *chcp_home_top_view;
@property (nonatomic, strong) UIView *chcp_home_middle_view;
@property (nonatomic, strong) UIView *chcp_home_bottom_view;
@property (nonatomic, strong) UIButton *chcp_home_calculate_button;
@end

@implementation CHCPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MAIN_VIEW_COLOR;

    [self initData];
    [self setupUI];

}

- (void)initData {
    self.chcp_home_item_list = @[
        @{
            @"title":@"币种",
            @"type":@"select-custom",
            @"data":@[@"人民币(¥)", @"美元($)", @"港币(HK)", @"欧元(€)", @"英镑(£)"],
            @"value":@"人民币(¥)"
        },
        @{
            @"title":@"工作时间",
            @"type":@"",
            @"value":@"09:00 - 18:00"
        },
        @{
            @"title":@"入职时间",
            @"type":@"select-time",
            @"value":@"2025-06-01"
        },
        @{
            @"title":@"月薪",
            @"type":@"input",
            @"value":@"30000"
        },
        @{
            @"title":@"工作制度",
            @"type":@"select-custom",
            @"data":@[@"双休", @"单休", @"大小周"],
            @"value":@"双休"
        },
    ];
    
    self.chcp_home_item_textField_list = [NSMutableArray array];
    self.chcp_start_calculate = NO;
}

- (void)setupUI {
    
    CGFloat chcp_home_item_startY = 10;
    if (self.chcp_start_calculate) {
        for (UIView *sub in self.chcp_home_top_view.subviews) {
            [sub removeFromSuperview];
        }
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 ,10, self.chcp_home_scrollView.bounds.size.width-40, 40)];
        [self.chcp_home_top_view addSubview:titleLabel];
        titleLabel.text = @"牛马时钟";
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:25];
        self.chcp_home_top_view.frame = CGRectMake(0, 0, self.chcp_home_scrollView.frame.size.width, CGRectGetMaxY(titleLabel.frame));
    } else {
        UILabel *chcp_home_title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, chcp_home_item_startY, self.chcp_home_scrollView.bounds.size.width - 20, 60)];
        [self.chcp_home_top_view addSubview:chcp_home_title_label];
        chcp_home_title_label.text = @"天价牛马们！\n你们准备好了吗？";
        chcp_home_title_label.textColor = [UIColor blackColor];
        chcp_home_title_label.textAlignment = NSTextAlignmentLeft;
        chcp_home_title_label.font = [UIFont boldSystemFontOfSize:35];
        chcp_home_title_label.numberOfLines = 0;
        [chcp_home_title_label sizeToFit];
        
        UIImageView *chcp_home_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(chcp_home_title_label.frame) + 10, self.chcp_home_scrollView.frame.size.width - 20, (self.chcp_home_scrollView.frame.size.width - 20) / 16 * 9)];
        [self.chcp_home_top_view addSubview:chcp_home_imageView];
        chcp_home_imageView.image = [UIImage imageNamed:@"cattle_01"];
        chcp_home_imageView.layer.cornerRadius = 8;
        chcp_home_imageView.layer.masksToBounds = YES;
        self.chcp_home_top_view.frame = CGRectMake(0, 0, self.chcp_home_scrollView.frame.size.width, CGRectGetMaxY(chcp_home_imageView.frame));
    }
    
    chcp_home_item_startY = CGRectGetMaxY(self.chcp_home_top_view.frame) + 10;
    
    self.chcp_home_middle_view.backgroundColor = [UIColor clearColor];
    if (!self.chcp_start_calculate) {
        CGFloat chcp_home_item_startY = 0;
        for (int i = 0; i < self.chcp_home_item_list.count; i++) {
            NSDictionary *item_dict = self.chcp_home_item_list[i];
            UIView *chcp_home_item_view = [[UIView alloc] initWithFrame:CGRectMake(0, chcp_home_item_startY, self.view.frame.size.width, 100)];
            [self.chcp_home_middle_view addSubview:chcp_home_item_view];
            
            UILabel *item_home_item_title_label = [[UILabel alloc] initWithFrame:CGRectMake(10,10, [UIScreen mainScreen].bounds.size.width-20, 40)];
            [chcp_home_item_view addSubview:item_home_item_title_label];
            item_home_item_title_label.text = item_dict[@"title"];
            item_home_item_title_label.textColor = [UIColor blackColor];
            item_home_item_title_label.textAlignment = NSTextAlignmentLeft;
            item_home_item_title_label.font = [UIFont boldSystemFontOfSize:17];
            
            NSString *type = item_dict[@"type"];
            UITextField *item_home_item_input_textField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(item_home_item_title_label.frame) + 10, chcp_home_item_view.frame.size.width - 20, 40)];
            [chcp_home_item_view addSubview:item_home_item_input_textField];
            item_home_item_input_textField.placeholder = @"请输入";
            item_home_item_input_textField.layer.borderColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1].CGColor;
            item_home_item_input_textField.layer.borderWidth = 1;
            item_home_item_input_textField.layer.cornerRadius = 5;
            item_home_item_input_textField.font = [UIFont systemFontOfSize:15];
            UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
            item_home_item_input_textField.leftView = leftview;
            item_home_item_input_textField.leftViewMode = UITextFieldViewModeAlways;
            item_home_item_input_textField.keyboardType = UIKeyboardTypeNumberPad;
            item_home_item_input_textField.tag = i;
            item_home_item_input_textField.delegate = self;
            if ([type isEqualToString:@""]) {
                item_home_item_input_textField.enabled = NO;
            } else if ([type isEqualToString:@"input"]) {
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(money_end_edit:) name:UITextFieldTextDidEndEditingNotification object:nil];
            }
            
            id value = item_dict[@"value"];
            if (value && [value isKindOfClass:[NSString class]]) {
                item_home_item_input_textField.text = item_dict[@"value"] ? : @"";
            }
            
            [self.chcp_home_item_textField_list addObject:item_home_item_input_textField];
            chcp_home_item_startY = CGRectGetMaxY(chcp_home_item_view.frame);
        }
    }
    
    self.chcp_home_middle_view.frame = CGRectMake(0, CGRectGetMaxY(self.chcp_home_top_view.frame) + 10, self.chcp_home_scrollView.frame.size.width, self.chcp_home_item_list.count * 100 + 20);
    self.chcp_home_calculate_button.frame = CGRectMake(10 , CGRectGetMaxY(self.chcp_home_middle_view.frame) + 20, [UIScreen mainScreen].bounds.size.width - 20, 44);
    self.chcp_home_calculate_button.hidden = self.chcp_start_calculate;
    
    if (self.chcp_start_calculate) {
        // 获取当前日历和时间
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *now = [NSDate date];
        // 获取当前日期组件
        NSDateComponents *nowComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond
                                                     fromDate:now];
        CHCPHomeCountdownView *countView = [self.chcp_home_bottom_view viewWithTag:202506];
        if (!countView) {
            // 创建早上9点的时间
            NSDateComponents *nineAMComponents = [nowComponents copy];
            nineAMComponents.hour = 9;
            nineAMComponents.minute = 0;
            nineAMComponents.second = 0;
            NSDate *nineAM = [calendar dateFromComponents:nineAMComponents];
            
            // 创建下午6点的时间
            NSDateComponents *sixPMComponents = [nowComponents copy];
            sixPMComponents.hour = 18;
            sixPMComponents.minute = 0;
            sixPMComponents.second = 0;
            NSDate *sixPM = [calendar dateFromComponents:sixPMComponents];
            
            // 计算时间差（秒）
            NSTimeInterval diffToNineAM = [nineAM timeIntervalSinceDate:now];
            NSTimeInterval diffToSixPM = [sixPM timeIntervalSinceDate:now];
            
            NSString *chcp_home_bottom_title_text = @"距离下班还有";
            NSInteger remainingSeconds = 3 * 3600 + 4 * 60 + 30;
            // 处理负值情况（如果时间已过，计算到明天的时间差）
            if (diffToSixPM < 0) {
                sixPMComponents.day += 1;
                sixPM = [calendar dateFromComponents:sixPMComponents];
                diffToSixPM = [sixPM timeIntervalSinceDate:now];
                chcp_home_bottom_title_text = @"距离上班还有";
                nineAMComponents.day += 1;
                nineAM = [calendar dateFromComponents:nineAMComponents];
                diffToNineAM = [nineAM timeIntervalSinceDate:now];
                remainingSeconds = diffToNineAM;
            } else {
                if (diffToNineAM < 0) {
                    nineAMComponents.day += 1;
                    nineAM = [calendar dateFromComponents:nineAMComponents];
                    diffToNineAM = [nineAM timeIntervalSinceDate:now];
                    chcp_home_bottom_title_text = @"距离下班还有";
                    remainingSeconds = diffToSixPM;
                } else {
                    chcp_home_bottom_title_text = @"距离上班还有";
                    remainingSeconds = diffToNineAM;
                }
            }
            
            if (diffToNineAM < 0) {
                nineAMComponents.day += 1;
                nineAM = [calendar dateFromComponents:nineAMComponents];
                diffToNineAM = [nineAM timeIntervalSinceDate:now];
            }
            
            if (diffToSixPM < 0) {
                sixPMComponents.day += 1;
                sixPM = [calendar dateFromComponents:sixPMComponents];
                diffToSixPM = [sixPM timeIntervalSinceDate:now];
            }
            
            UILabel *chcp_home_bottom_title_label = [[UILabel alloc] initWithFrame:CGRectMake(20,10, [UIScreen mainScreen].bounds.size.width-40, 30)];
            [self.chcp_home_bottom_view addSubview:chcp_home_bottom_title_label];
            chcp_home_bottom_title_label.text = chcp_home_bottom_title_text;
            chcp_home_bottom_title_label.textColor = [UIColor blackColor];
            chcp_home_bottom_title_label.textAlignment = NSTextAlignmentCenter;
            chcp_home_bottom_title_label.font = [UIFont boldSystemFontOfSize:20];
                    
            countView = [[CHCPHomeCountdownView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(chcp_home_bottom_title_label.frame) + 10, self.chcp_home_bottom_view.frame.size.width - 60, 80) remainingSeconds:remainingSeconds];
            [self.chcp_home_bottom_view addSubview:countView];
            countView.tag = 202506;
            [countView start];
        }
        
        UILabel *chcp_home_bottom_title_label_1 = [self chcp_home_bottom_item_labelWithFrame:CGRectMake(20, CGRectGetMaxY(countView.frame) + 20, [UIScreen mainScreen].bounds.size.width - 40, 30) tag:100 text:@"今日牛马收益" isTitle:YES];
        
        NSString *bizhong = [self.chcp_home_item_textField_list[0] text];
        NSString *yuexin = [self.chcp_home_item_textField_list[self.chcp_home_item_textField_list.count - 2] text];
        NSString *zhidu = [self.chcp_home_item_textField_list[self.chcp_home_item_textField_list.count - 1] text];
        CGFloat yuexin_f = [yuexin floatValue];
        
        NSString *today_money = @"";
        CGFloat days = 21.75;
        if ([zhidu isEqualToString:@"双休"]) {
            today_money = [NSString stringWithFormat:@" %@% .2lf",bizhong ,yuexin_f / days];
        } else if ([zhidu isEqualToString:@"单休"]) {
            days = 25.0;
            today_money = [NSString stringWithFormat:@" %@ %.2lf",bizhong ,yuexin_f / days];
        } else if ([zhidu isEqualToString:@"大小周"]) {
            days = 23.0;
            today_money = [NSString stringWithFormat:@" %@ %.2lf",bizhong ,yuexin_f / days];
        }
        
        NSString *month_money = [NSString stringWithFormat:@"%@ %.2lf",bizhong ,yuexin_f * nowComponents.day / days];
        NSString *year_money = [NSString stringWithFormat:@"%@ %.2lf",bizhong ,yuexin_f * 12 * nowComponents.month * 31 / 365.0];;
        
        UILabel *chcp_home_bottom_title_label_2 = [self chcp_home_bottom_item_labelWithFrame:CGRectMake(20, CGRectGetMaxY(chcp_home_bottom_title_label_1.frame) + 10, [UIScreen mainScreen].bounds.size.width-40, 30) tag:200 text:today_money isTitle:NO];
        UILabel *chcp_home_bottom_title_label_3 = [self chcp_home_bottom_item_labelWithFrame:CGRectMake(20, CGRectGetMaxY(chcp_home_bottom_title_label_2.frame) + 20, [UIScreen mainScreen].bounds.size.width - 40, 30) tag:300 text:@"本月累计卷资" isTitle:YES];
        UILabel *chcp_home_bottom_title_label_4 = [self chcp_home_bottom_item_labelWithFrame:CGRectMake(20, CGRectGetMaxY(chcp_home_bottom_title_label_3.frame) + 20, [UIScreen mainScreen].bounds.size.width - 40, 30) tag:400 text:month_money isTitle:NO];
        UILabel *chcp_home_bottom_title_label_5 = [self chcp_home_bottom_item_labelWithFrame:CGRectMake(20, CGRectGetMaxY(chcp_home_bottom_title_label_4.frame) + 20, [UIScreen mainScreen].bounds.size.width - 40, 30) tag:500 text:@"年度牛马成就" isTitle:YES];
        UILabel *chcp_home_bottom_title_label_6 = [self chcp_home_bottom_item_labelWithFrame:CGRectMake(20, CGRectGetMaxY(chcp_home_bottom_title_label_5.frame) + 20, [UIScreen mainScreen].bounds.size.width - 40, 30) tag:600 text:year_money isTitle:NO];
        
        self.chcp_home_bottom_view.frame = CGRectMake(0, self.chcp_home_bottom_view.frame.origin.y, self.chcp_home_bottom_view.frame.size.width, CGRectGetMaxY(chcp_home_bottom_title_label_6.frame) + 20);
        self.chcp_home_scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.chcp_home_bottom_view.frame) + 30);
    }
    else {
        self.chcp_home_scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.chcp_home_calculate_button.frame) + 30);
    }
}

- (UILabel *)chcp_home_bottom_item_labelWithFrame:(CGRect)frame tag:(NSInteger)tag text:(NSString *)text isTitle:(BOOL)isTitle{
    UILabel *chcp_home_bottom_title_label = [self.chcp_home_bottom_view viewWithTag:tag];
    if (!chcp_home_bottom_title_label) {
        chcp_home_bottom_title_label = [[UILabel alloc] initWithFrame:frame];
        [self.chcp_home_bottom_view addSubview:chcp_home_bottom_title_label];
        chcp_home_bottom_title_label.tag = tag;
        chcp_home_bottom_title_label.textAlignment = NSTextAlignmentCenter;
        chcp_home_bottom_title_label.font = [UIFont boldSystemFontOfSize:25];
        chcp_home_bottom_title_label.textColor = isTitle ? [UIColor blackColor] : [UIColor systemOrangeColor];
    }
    chcp_home_bottom_title_label.text = text;
    return chcp_home_bottom_title_label;
}

- (UIScrollView *)chcp_home_scrollView {
    if (!_chcp_home_scrollView) {
        _chcp_home_scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_chcp_home_scrollView];
        _chcp_home_scrollView.backgroundColor = [UIColor clearColor];
        _chcp_home_scrollView.delegate = self;
    }
    return _chcp_home_scrollView;
}

- (UIView *)chcp_home_top_view {
    if (!_chcp_home_top_view) {
        _chcp_home_top_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        [_chcp_home_scrollView addSubview:_chcp_home_top_view];
    }
    return _chcp_home_top_view;
}

- (UIView *)chcp_home_middle_view {
    if (!_chcp_home_middle_view) {
        _chcp_home_middle_view = [[UIView alloc] initWithFrame:CGRectZero];
        [_chcp_home_scrollView addSubview:_chcp_home_middle_view];
    }
    return _chcp_home_middle_view;
}

- (UIView *)chcp_home_bottom_view {
    if (!_chcp_home_bottom_view) {
        _chcp_home_bottom_view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.chcp_home_middle_view.frame) + 20, self.view.frame.size.width, 100)];
        [_chcp_home_scrollView addSubview:_chcp_home_bottom_view];
    }
    return _chcp_home_bottom_view;
}

- (UIButton *)chcp_home_calculate_button {
    if (!_chcp_home_calculate_button) {
        _chcp_home_calculate_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.chcp_home_scrollView addSubview:_chcp_home_calculate_button];
        [_chcp_home_calculate_button setTitle:@"开始计算" forState:UIControlStateNormal];
        [_chcp_home_calculate_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _chcp_home_calculate_button.titleLabel.font = [UIFont systemFontOfSize:18];
        _chcp_home_calculate_button.layer.cornerRadius = 8;
        _chcp_home_calculate_button.layer.masksToBounds = YES;
        _chcp_home_calculate_button.backgroundColor = [UIColor systemOrangeColor];
        [_chcp_home_calculate_button addTarget:self action:@selector(chcp_home_calculate_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chcp_home_calculate_button;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSDictionary *item_dict = self.chcp_home_item_list[textField.tag];
    BOOL result = YES;
    NSString *type = item_dict[@"type"];
    if ([type isEqualToString:@"select-custom"] || [type isEqualToString:@"select-time"]) {
        [self selectWithType:type item:item_dict tag:textField.tag];
        return NO;
    } else if (type.length == 0) {
        result = NO;
    }
    return result;
}

- (void)selectWithType:(NSString *)type item:(NSDictionary *)item_dict tag:(NSInteger)tag {
    [self.view endEditing:YES];
    UITextField *textField = self.chcp_home_item_textField_list[tag];
    if ([type isEqualToString:@"select-custom"]) {
        BRTextPickerView *pickView = [[BRTextPickerView alloc] initWithPickerMode:BRTextPickerComponentSingle];
        pickView.dataSourceArr = item_dict[@"data"];
        [pickView show];
        pickView.singleResultBlock = ^(BRTextModel * _Nullable model, NSInteger index) {
            textField.text = model.text;
            
            if (self.chcp_start_calculate) {
                [self setupUI];
            }
        };
    } else if ([type isEqualToString:@"select-time"]) {
        [BRDatePickerView showDatePickerWithMode:BRDatePickerModeYMD title:@"选择时间" selectValue:nil minDate:nil maxDate:[NSDate date] isAutoSelect:YES resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
            textField.text = selectValue;
            
            if (self.chcp_start_calculate) {
                [self setupUI];
            }
        }];
    }
}

- (void)chcp_home_calculate_buttonClick:(UIButton *)button{
    self.chcp_start_calculate = YES;
    
    [self setupUI];
}


NSDictionary<NSString *, NSNumber *> *calculateTimeDifferences(void) {
    // 获取当前日历和时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    
    // 获取当前日期组件
    NSDateComponents *nowComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond
                                                 fromDate:now];
    
    // 创建早上9点的时间
    NSDateComponents *nineAMComponents = [nowComponents copy];
    nineAMComponents.hour = 9;
    nineAMComponents.minute = 0;
    nineAMComponents.second = 0;
    NSDate *nineAM = [calendar dateFromComponents:nineAMComponents];
    
    // 创建下午6点的时间
    NSDateComponents *sixPMComponents = [nowComponents copy];
    sixPMComponents.hour = 18;
    sixPMComponents.minute = 0;
    sixPMComponents.second = 0;
    NSDate *sixPM = [calendar dateFromComponents:sixPMComponents];
    
    // 计算时间差（秒）
    NSTimeInterval diffToNineAM = [nineAM timeIntervalSinceDate:now];
    NSTimeInterval diffToSixPM = [sixPM timeIntervalSinceDate:now];
    
    // 处理负值情况（如果时间已过，计算到明天的时间差）
    if (diffToNineAM < 0) {
        nineAMComponents.day += 1;
        nineAM = [calendar dateFromComponents:nineAMComponents];
        diffToNineAM = [nineAM timeIntervalSinceDate:now];
    }
    
    if (diffToSixPM < 0) {
        sixPMComponents.day += 1;
        sixPM = [calendar dateFromComponents:sixPMComponents];
        diffToSixPM = [sixPM timeIntervalSinceDate:now];
    }
    
    // 返回结果字典
    return @{
        @"timeToNineAM": @(diffToNineAM),
        @"timeToSixPM": @(diffToSixPM),
        @"nineAM": nineAM,
        @"sixPM": sixPM
    };
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)money_end_edit:(NSNotification *)noti {
    if (self.chcp_start_calculate) {
        [self setupUI];
    }
}

@end
