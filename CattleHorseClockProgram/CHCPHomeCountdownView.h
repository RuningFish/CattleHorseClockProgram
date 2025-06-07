//
//  CHCPHomeCountdownView.h
//  CattleHorseClockProgram
//
//  Created by runingfish on 2025/6/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHCPHomeCountdownView : UIView
- (instancetype)initWithFrame:(CGRect)frame remainingSeconds:(NSInteger)remainingSeconds;
- (void)start;
@end

NS_ASSUME_NONNULL_END
