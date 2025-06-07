//
//  CHCPHomeCountdownView.m
//  CattleHorseClockProgram
//
//  Created by runingfish on 2025/6/7.
//

#import "CHCPHomeCountdownView.h"
#import "CHCPDigitScrollView.h"
@interface CHCPHomeCountdownView ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger remainingSeconds;

// 时间显示视图
@property (nonatomic, strong) CHCPDigitScrollView *hourTensDigit;
@property (nonatomic, strong) CHCPDigitScrollView *hourOnesDigit;
@property (nonatomic, strong) CHCPDigitScrollView *minuteTensDigit;
@property (nonatomic, strong) CHCPDigitScrollView *minuteOnesDigit;
@property (nonatomic, strong) CHCPDigitScrollView *secondTensDigit;
@property (nonatomic, strong) CHCPDigitScrollView *secondOnesDigit;

@property (nonatomic, strong) UILabel *colon1;
@property (nonatomic, strong) UILabel *colon2;

@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *resetButton;
@end

@implementation CHCPHomeCountdownView

- (instancetype)initWithFrame:(CGRect)frame remainingSeconds:(NSInteger)remainingSeconds {
    self.remainingSeconds = remainingSeconds;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setupUI];
        [self updateDisplay];
    }
    return self;
}

- (void)setupUI {
    CGFloat digitWidth = 35;
    CGFloat digitHeight = 60;
    CGFloat spacing = 10;
    CGFloat totalWidth = digitWidth * 6 + spacing * 2 + 20 * 2;
    CGFloat startX = (self.frame.size.width - totalWidth) / 2;
    CGFloat y = (self.frame.size.height - digitHeight) / 2;
    
    UIColor *color_hour = [UIColor clearColor];
    UIColor *color_minute = [UIColor clearColor];
    UIColor *color_second = [UIColor clearColor];
    // 小时十位
    self.hourTensDigit = [[CHCPDigitScrollView alloc] initWithFrame:CGRectMake(startX, y, digitWidth, digitHeight)];
    [self addSubview:self.hourTensDigit];
    
    // 小时个位
    self.hourOnesDigit = [[CHCPDigitScrollView alloc] initWithFrame:CGRectMake(startX + digitWidth, y, digitWidth, digitHeight)];
    [self addSubview:self.hourOnesDigit];
    self.hourTensDigit.backgroundColor = color_hour;
    self.hourOnesDigit.backgroundColor = color_hour;
    
    // 冒号1
    self.colon1 = [[UILabel alloc] initWithFrame:CGRectMake(startX + digitWidth * 2 + spacing, y, 20, digitHeight)];
    self.colon1.text = @":";
    self.colon1.textColor = [UIColor whiteColor];
    self.colon1.font = [UIFont systemFontOfSize:40];
    self.colon1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.colon1];
    
    // 分钟十位
    self.minuteTensDigit = [[CHCPDigitScrollView alloc] initWithFrame:CGRectMake(startX + digitWidth * 2 + spacing + 20, y, digitWidth, digitHeight)];
    [self addSubview:self.minuteTensDigit];
    
    // 分钟个位
    self.minuteOnesDigit = [[CHCPDigitScrollView alloc] initWithFrame:CGRectMake(startX + digitWidth * 3 + spacing + 20, y, digitWidth, digitHeight)];
    [self addSubview:self.minuteOnesDigit];
    self.minuteTensDigit.backgroundColor = color_minute;
    self.minuteOnesDigit.backgroundColor = color_minute;
    
    // 冒号2
    self.colon2 = [[UILabel alloc] initWithFrame:CGRectMake(startX + digitWidth * 4 + spacing * 2 + 20, y, 20, digitHeight)];
    self.colon2.text = @":";
    self.colon2.textColor = [UIColor whiteColor];
    self.colon2.font = [UIFont systemFontOfSize:40];
    self.colon2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.colon2];
    
    // 秒钟十位
    self.secondTensDigit = [[CHCPDigitScrollView alloc] initWithFrame:CGRectMake(startX + digitWidth * 4 + spacing * 2 + 40, y, digitWidth, digitHeight)];
    [self addSubview:self.secondTensDigit];
    
    // 秒钟个位
    self.secondOnesDigit = [[CHCPDigitScrollView alloc] initWithFrame:CGRectMake(startX + digitWidth * 5 + spacing * 2 + 40, y, digitWidth, digitHeight)];
    [self addSubview:self.secondOnesDigit];
    
    self.secondTensDigit.backgroundColor = color_second;
    self.secondOnesDigit.backgroundColor = color_second;
    
    // 添加闪烁动画
    [self startColonBlink];
}

- (void)start {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats:YES];
}

- (void)setupControlButtons {
    // 开始/暂停按钮
    self.startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.startButton.frame = CGRectMake((self.bounds.size.width - 200) / 2, 300, 200, 50);
    [self.startButton setTitle:@"开始倒计时" forState:UIControlStateNormal];
    [self.startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.startButton.titleLabel.font = [UIFont systemFontOfSize:20];
    self.startButton.backgroundColor = [UIColor systemBlueColor];
    self.startButton.layer.cornerRadius = 10;
    [self.startButton addTarget:self action:@selector(toggleCountdown) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.startButton];
    
    // 重置按钮
    self.resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.resetButton.frame = CGRectMake((self.bounds.size.width - 200) / 2, 370, 200, 50);
    [self.resetButton setTitle:@"重置" forState:UIControlStateNormal];
    [self.resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.resetButton.titleLabel.font = [UIFont systemFontOfSize:20];
    self.resetButton.backgroundColor = [UIColor systemGrayColor];
    self.resetButton.layer.cornerRadius = 10;
    [self.resetButton addTarget:self action:@selector(resetCountdown) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.resetButton];
}

- (void)startColonBlink {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @1.0;
    animation.toValue = @0.3;
    animation.duration = 1.0;
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VALF;
    
    [self.colon1.layer addAnimation:animation forKey:@"colonBlink"];
    [self.colon2.layer addAnimation:animation forKey:@"colonBlink"];
}

- (void)toggleCountdown {
    if (self.timer) {
        // 暂停计时器
        [self.timer invalidate];
        self.timer = nil;
        [self.startButton setTitle:@"继续倒计时" forState:UIControlStateNormal];
    } else {
        // 启动/继续计时器
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats:YES];
        [self.startButton setTitle:@"暂停倒计时" forState:UIControlStateNormal];
    }
}

- (void)resetCountdown {
    [self.timer invalidate];
    self.timer = nil;
    
    // 重置为初始时间
    self.remainingSeconds = 1 * 3600 + 30 * 60 + 15;
    [self updateDisplay];
    
    [self.startButton setTitle:@"开始倒计时" forState:UIControlStateNormal];
}

- (void)updateCountdown {
    if (self.remainingSeconds > 0) {
        self.remainingSeconds--;
        [self updateDisplay];
    } else {
        [self.timer invalidate];
        self.timer = nil;
        [self.startButton setTitle:@"倒计时结束" forState:UIControlStateNormal];
        self.startButton.enabled = NO;
        
        // 倒计时结束效果
        [UIView animateWithDuration:0.5 animations:^{
            self.backgroundColor = [UIColor clearColor];
        }];
    }
}

- (void)updateDisplay {
    NSInteger hours = self.remainingSeconds / 3600;
    NSInteger minutes = (self.remainingSeconds % 3600) / 60;
    NSInteger seconds = self.remainingSeconds % 60;
    
    // 小时十位
    [self.hourTensDigit setValue:hours / 10 animated:YES];
    // 小时个位
    [self.hourOnesDigit setValue:hours % 10 animated:YES];
    
    // 分钟十位
    [self.minuteTensDigit setValue:minutes / 10 animated:YES];
    // 分钟个位
    [self.minuteOnesDigit setValue:minutes % 10 animated:YES];
    
    // 秒钟十位
    [self.secondTensDigit setValue:seconds / 10 animated:YES];
    // 秒钟个位
    [self.secondOnesDigit setValue:seconds % 10 animated:YES];
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}
@end
