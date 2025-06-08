//
//  CHCPRecordTableViewCell.h
//  CattleHorseClockProgram
//
//  Created by runingfish on 2025/6/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHCPRecordTableViewCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *dict;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
