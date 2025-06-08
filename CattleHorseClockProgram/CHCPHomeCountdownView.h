//
//  CHCPHomeCountdownView.h
//  CattleHorseClockProgram
//
//  
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHCPHomeCountdownView : UIView
- (instancetype)initWithFrame:(CGRect)frame remainingSeconds:(NSInteger)remainingSeconds;
- (void)start;
@end

NS_ASSUME_NONNULL_END
