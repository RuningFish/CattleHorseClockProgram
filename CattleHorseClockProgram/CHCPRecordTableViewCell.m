//
//  CHCPRecordTableViewCell.m
//  CattleHorseClockProgram
//
//  
//

#import "CHCPRecordTableViewCell.h"

@interface CHCPRecordTableViewCell ()
@property (nonatomic, strong) UILabel *chcp_record_item_titleLabel;
@property (nonatomic, strong) UILabel *chcp_record_item_moneyLabel;
@property (nonatomic, strong) UILabel *chcp_record_item_dateLabel;
@property (nonatomic, strong) UILabel *chcp_record_item_zhiduLabel;
@end

@implementation CHCPRecordTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *identifier = @"CHCPRecordTableViewCell";
    CHCPRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CHCPRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = [UIColor clearColor];
        UIView *bottomView = [[UIView alloc] init];
        [self.contentView addSubview:bottomView];
        bottomView.backgroundColor = [UIColor clearColor];
        bottomView.layer.cornerRadius = 8;
        bottomView.layer.masksToBounds = YES;
        bottomView.layer.borderColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1].CGColor;
        bottomView.layer.borderWidth = 1;
        
        self.chcp_record_item_titleLabel = [[UILabel alloc] init];
        [bottomView addSubview:self.chcp_record_item_titleLabel];
        self.chcp_record_item_titleLabel.font = [UIFont systemFontOfSize:15];
        self.chcp_record_item_titleLabel.textColor = [UIColor blackColor];
        self.chcp_record_item_titleLabel.numberOfLines = 2;
        
        self.chcp_record_item_moneyLabel = [[UILabel alloc] init];
        [bottomView addSubview:self.chcp_record_item_moneyLabel];
        self.chcp_record_item_moneyLabel.font = [UIFont systemFontOfSize:15];
        self.chcp_record_item_moneyLabel.textColor = [UIColor blackColor];
        
        self.chcp_record_item_dateLabel = [[UILabel alloc] init];
        [bottomView addSubview:self.chcp_record_item_dateLabel];
        self.chcp_record_item_dateLabel.font = [UIFont systemFontOfSize:15];
        self.chcp_record_item_dateLabel.textColor = [UIColor blackColor];
        self.chcp_record_item_dateLabel.textAlignment = NSTextAlignmentLeft;
        
        self.chcp_record_item_zhiduLabel = [[UILabel alloc] init];
        [bottomView addSubview:self.chcp_record_item_zhiduLabel];
        self.chcp_record_item_zhiduLabel.font = [UIFont systemFontOfSize:15];
        self.chcp_record_item_zhiduLabel.textColor = [UIColor blackColor];
        self.chcp_record_item_zhiduLabel.textAlignment = NSTextAlignmentLeft;
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(10);
            make.right.offset(-10);
            make.bottom.offset(0);
        }];
        
        [self.chcp_record_item_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.left.offset(10);
            make.right.offset(-10);
            make.height.mas_greaterThanOrEqualTo(30);
        }];
        
        [self.chcp_record_item_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.equalTo(self.chcp_record_item_titleLabel.mas_bottom).offset(0);
            make.right.offset(-10);
            make.height.mas_equalTo(30);
        }];
        
        [self.chcp_record_item_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.chcp_record_item_titleLabel.mas_left).offset(0);
            make.right.offset(-10);
            make.top.equalTo(self.chcp_record_item_moneyLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(self.chcp_record_item_moneyLabel);
        }];
        
        [self.chcp_record_item_zhiduLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.chcp_record_item_titleLabel.mas_left).offset(0);
            make.right.offset(-10);
            make.top.equalTo(self.chcp_record_item_dateLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(30);
            make.bottom.offset(-10);
        }];
    }
    
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    _dict = dict;
    self.chcp_record_item_titleLabel.text = [NSString stringWithFormat:@"工作时长:%@",dict[@"time"]];
    self.chcp_record_item_moneyLabel.text = [NSString stringWithFormat:@"月薪:%@ %@",dict[@"type"], dict[@"money"]];
    self.chcp_record_item_dateLabel.text = [NSString stringWithFormat:@"%@",dict[@"date"]];
    self.chcp_record_item_zhiduLabel.text = [NSString stringWithFormat:@"%@",dict[@"zhidu"]];
}

@end
