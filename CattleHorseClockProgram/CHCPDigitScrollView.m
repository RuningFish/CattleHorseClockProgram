//
//  CHCPDigitScrollView.m
//  CattleHorseClockProgram
//
//  
//

#import "CHCPDigitScrollView.h"

@implementation CHCPDigitScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    // 创建滚动视图 - 使用三组数字实现平滑过渡
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.userInteractionEnabled = NO;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height * 30); // 三组数字
    [self addSubview:self.scrollView];
    
    // 添加数字标签 (0-9重复三次)
    NSMutableArray *labels = [NSMutableArray array];
    for (int set = 0; set < 3; set++) {
        for (int i = 0; i < 10; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (set * 10 + i) * self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
            label.text = [NSString stringWithFormat:@"%d", i];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont monospacedDigitSystemFontOfSize:40 weight:UIFontWeightBold];
            label.textColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];;
            [self.scrollView addSubview:label];
            [labels addObject:label];
        }
    }
    self.labels = [labels copy];
    
    // 设置默认值 - 初始位置在中间组
    self.currentValue = 0;
    [self.scrollView setContentOffset:CGPointMake(0, 10 * self.bounds.size.height) animated:NO];
}

- (void)setValue:(NSInteger)value animated:(BOOL)animated {
    if (value < 0 || value > 9) return;
    
    // 计算当前在中间组的位置
    CGFloat currentOffset = self.scrollView.contentOffset.y;
    NSInteger currentSet = (NSInteger)(currentOffset / (self.bounds.size.height * 10));
    CGFloat currentPosition = currentOffset - (currentSet * 10 * self.bounds.size.height);
    NSInteger currentValueInSet = (NSInteger)(currentPosition / self.bounds.size.height);
    
    // 计算目标位置 - 始终在中间组
    CGFloat targetOffset = 10 * self.bounds.size.height + value * self.bounds.size.height;
    
    if (animated) {
        // 特殊处理从0到9的过渡
        if (currentValueInSet == 0 && value == 9) {
            // 向下滚动到下一组的9
            CGFloat tempOffset = 20 * self.bounds.size.height + 9 * self.bounds.size.height;
            [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.scrollView.contentOffset = CGPointMake(0, tempOffset);
            } completion:^(BOOL finished) {
                // 完成后立即重置到中间组的9位置
                self.scrollView.contentOffset = CGPointMake(0, targetOffset);
                self.currentValue = value;
            }];
        }
        // 处理从9到0的过渡
        else if (currentValueInSet == 9 && value == 0) {
            // 向上滚动到上一组的0
            CGFloat tempOffset = 0 * self.bounds.size.height + 0 * self.bounds.size.height;
            [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.scrollView.contentOffset = CGPointMake(0, tempOffset);
            } completion:^(BOOL finished) {
                // 完成后立即重置到中间组的0位置
                self.scrollView.contentOffset = CGPointMake(0, targetOffset);
                self.currentValue = value;
            }];
        }
        // 正常变化
        else {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.scrollView.contentOffset = CGPointMake(0, targetOffset);
            } completion:nil];
            self.currentValue = value;
        }
    } else {
        self.scrollView.contentOffset = CGPointMake(0, targetOffset);
        self.currentValue = value;
    }
}

@end
