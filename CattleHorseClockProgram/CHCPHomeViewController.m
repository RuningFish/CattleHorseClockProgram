//
//  CHCPHomeViewController.m
//  CattleHorseClockProgram
//
//  Created by runingfish on 2025/6/3.
//

#import "CHCPHomeViewController.h"

@interface CHCPHomeViewController ()<UITextFieldDelegate>
@property (nonatomic, copy) NSArray *chcp_home_item_list;
@property (nonatomic, strong) NSMutableArray *chcp_home_item_textField_list;
@end

@implementation CHCPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
}

- (void)setupUI {
    UIScrollView *chcp_home_scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:chcp_home_scrollView];
    chcp_home_scrollView.backgroundColor = [UIColor clearColor];
    
    UILabel *chcp_home_title_label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, chcp_home_scrollView.bounds.size.width-40, 60)];
    [chcp_home_scrollView addSubview:chcp_home_title_label];
    chcp_home_title_label.text = @"天价牛马们！\n你们准备好了吗？";
    chcp_home_title_label.textColor = [UIColor blackColor];
    chcp_home_title_label.textAlignment = NSTextAlignmentLeft;
    chcp_home_title_label.font = [UIFont boldSystemFontOfSize:35];
    chcp_home_title_label.numberOfLines = 0;
    [chcp_home_title_label sizeToFit];
    
    UIImageView *chcp_home_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(chcp_home_title_label.frame) + 10, chcp_home_scrollView.frame.size.width, chcp_home_scrollView.frame.size.width / 16 * 9)];
    [chcp_home_scrollView addSubview:chcp_home_imageView];
    chcp_home_imageView.image = [UIImage imageNamed:@"cattle_01"];
    
    CGFloat chcp_home_item_startY = CGRectGetMaxY(chcp_home_imageView.frame) + 10;
    for (int i = 0; i < self.chcp_home_item_list.count; i++) {
        NSDictionary *item_dict = self.chcp_home_item_list[i];
        UIView *chcp_home_item_view = [[UIView alloc] initWithFrame:CGRectMake(0, chcp_home_item_startY, self.view.frame.size.width, 100)];
        [chcp_home_scrollView addSubview:chcp_home_item_view];
        
        UILabel *item_home_item_title_label = [[UILabel alloc] initWithFrame:CGRectMake(10,0, [UIScreen mainScreen].bounds.size.width-20, 40)];
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
        }
        
        id value = item_dict[@"value"];
        if (value && [value isKindOfClass:[NSString class]]) {
            item_home_item_input_textField.text = item_dict[@"value"] ? : @"";
        }

        [self.chcp_home_item_textField_list addObject:item_home_item_input_textField];
        chcp_home_item_startY = CGRectGetMaxY(chcp_home_item_view.frame);
    }
    
    UIButton *chcp_home_calculate_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [chcp_home_scrollView addSubview:chcp_home_calculate_button];
    chcp_home_calculate_button.frame = CGRectMake(10 , chcp_home_item_startY + 20, [UIScreen mainScreen].bounds.size.width - 20, 44);
    [chcp_home_calculate_button setTitle:@"开始计算" forState:UIControlStateNormal];
    [chcp_home_calculate_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    chcp_home_calculate_button.titleLabel.font = [UIFont systemFontOfSize:18];
    chcp_home_calculate_button.layer.cornerRadius = 8;
    chcp_home_calculate_button.layer.masksToBounds = YES;
    chcp_home_calculate_button.backgroundColor = [UIColor systemOrangeColor];
    [chcp_home_calculate_button addTarget:self action:@selector(chcp_home_calculate_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    chcp_home_scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(chcp_home_calculate_button.frame) + 30);
    
    NSLog(@"one ----- viewDidLoad");
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
    UITextField *textField = self.chcp_home_item_textField_list[tag];
    if ([type isEqualToString:@"select-custom"]) {
        BRDatePickerView *pickView = [[BRDatePickerView alloc] initWithPickerMode:BRDatePickerModeY];
        pickView.monthNames = @[@"1",@"2",@"3"];
        [pickView show];
    } else if ([type isEqualToString:@"select-time"]) {
        [BRDatePickerView showDatePickerWithMode:BRDatePickerModeYMD title:@"选择时间" selectValue:nil minDate:nil maxDate:[NSDate date] isAutoSelect:YES resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
            textField.text = selectValue;
        }];
    }
    
    //[self.view endEditing:YES];
//    NSInteger index = -1;
//    for (int i = 0; i < self.chcp_home_item_value_list.count; i ++) {
//        NSString *obj = self.chcp_home_item_value_list[i];
//        if ([obj isEqualToString:@""] || obj.length == 0) {
//            index = i;
//            break;
//        }
//    }
//    
//    NSLog(@"--=========== %@",self.chcp_home_item_value_list);
//    NSString *title = @"提示";
//    NSString *message = @"";
//    if (index >= 0) {
//        NSDictionary *obj = self.chcp_home_itemList[index];
//        message = [NSString stringWithFormat:@"%@%@",[obj[@"type"] isEqualToString:@"slider"] ? @"请选择" :@"请输入",obj[@"title"]];
//    } else {
//        title = @"计算结果";
//        CGFloat result_1 = 1.0f;
//        CGFloat result_2 = 1.0f;
//        
//        for (int i = 0; i < self.chcp_home_item_value_list.count; i ++) {
//            CGFloat value = [self.chcp_home_item_value_list[i] floatValue];
//            if (i < self.chcp_home_item_value_list.count - 2) {
//                result_1 = result_1 * value;
//            } else {
//                result_2 = result_2 * value;
//            }
//        }
//        
//        message = [NSString stringWithFormat:@"水平作用力: %.2lf KN \n 作用面积: %.2lf m²",result_1 * 100, result_2 * 100];
//    }
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
//                                                                             message:message
//                                                                      preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [alertController addAction:sureAction];
//    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)chcp_home_calculate_buttonClick:(UIButton *)button{
    
}

@end
