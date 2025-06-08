//
//  CHCPRecordTableViewCell.h
//  CattleHorseClockProgram
//
//  
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHCPRecordTableViewCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *dict;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
