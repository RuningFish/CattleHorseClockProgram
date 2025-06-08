//
//  CHCPFeedbackViewController.m
//  CattleHorseClockProgram
//
//  
//

#import "CHCPFeedbackViewController.h"

@implementation CHCPFeedbackViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
    UILabel *chcp_feedback_title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, self.view.frame.size.width-20, 40)];
    [self.view addSubview:chcp_feedback_title_label];
    chcp_feedback_title_label.text = @"请将您的意见或建议填入下方，以便我们改进";
    chcp_feedback_title_label.textColor = [UIColor blackColor];
    chcp_feedback_title_label.textAlignment = NSTextAlignmentLeft;
    chcp_feedback_title_label.font = [UIFont systemFontOfSize:16];
    
    UITextView *chcp_feedback_textView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(chcp_feedback_title_label.frame) + 13, self.view.frame.size.width - 20, 143)];
    [self.view addSubview:chcp_feedback_textView];
    chcp_feedback_textView.layer.borderWidth = 1;
    chcp_feedback_textView.layer.borderColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1].CGColor;
    chcp_feedback_textView.layer.cornerRadius = 5;
    chcp_feedback_textView.layer.masksToBounds = YES;
    
    UIButton *chcp_feedback_confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:chcp_feedback_confirmButton];
    chcp_feedback_confirmButton.frame = CGRectMake(10, CGRectGetMaxY(chcp_feedback_textView.frame) + 33, [UIScreen mainScreen].bounds.size.width-20, 44);
    [chcp_feedback_confirmButton setTitle:@"提交" forState:UIControlStateNormal];
    [chcp_feedback_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    chcp_feedback_confirmButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [chcp_feedback_confirmButton addTarget:self action:@selector(chcp_feedback_confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    chcp_feedback_confirmButton.backgroundColor = [UIColor systemOrangeColor];
    chcp_feedback_confirmButton.layer.cornerRadius = 10;
    chcp_feedback_confirmButton.layer.masksToBounds = YES;
}

- (void)chcp_feedback_confirmButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
