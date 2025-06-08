//
//  CHCPDigitScrollView.h
//  CattleHorseClockProgram
//
//  
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHCPDigitScrollView : UIView
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger currentValue;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, assign) BOOL shouldAnimateToNextSet;

- (void)setValue:(NSInteger)value animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
