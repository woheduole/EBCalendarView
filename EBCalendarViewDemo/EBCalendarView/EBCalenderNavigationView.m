//
//  EBCalenderNavigationView.m
//  EBCalendarViewDemo
//
//  Created by HoYo on 2018/5/3.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import "EBCalenderNavigationView.h"
#import "UIColor+EBAdd.h"
#import "NSDate+EBAdd.h"

@interface EBCalenderNavigationView()
@property (nonatomic, strong) UIButton *lastMonthButton, *nextMonthButton;
@property (nonatomic, strong) UILabel *showDateLabel;
@end
static CGFloat const kEBCalenderNavigationViewButtonWidth = 70;
@implementation EBCalenderNavigationView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupFrame];
}

#pragma mark - Setup

- (void)setupView {
    [self addSubview:self.showDateLabel];
    [self addSubview:self.lastMonthButton];
    [self addSubview:self.nextMonthButton];
}

- (void)setupFrame {
    CGFloat viewHeight = CGRectGetHeight(self.bounds)
    , viewWidth = CGRectGetWidth(self.bounds);
    _lastMonthButton.frame = CGRectMake(0, 0, kEBCalenderNavigationViewButtonWidth, viewHeight);
    _showDateLabel.frame = CGRectMake(CGRectGetMaxX(_lastMonthButton.frame) + 1, 0, viewWidth - kEBCalenderNavigationViewButtonWidth * 2 - 2, viewHeight);
    _nextMonthButton.frame = CGRectMake(CGRectGetMaxX(_showDateLabel.frame) + 1, 0, kEBCalenderNavigationViewButtonWidth, viewHeight);
}

#pragma mark - Events
- (void)changeMonthAction:(UIButton*)button {
    BOOL isNextMonth = NO;
    if ([button isEqual:_nextMonthButton]) {
        // 下个月
        isNextMonth = YES;
    }
    if ([self.delegate respondsToSelector:@selector(calenderNavigationViewDidChangeMonth:isNextMonth:)]) {
        [self.delegate calenderNavigationViewDidChangeMonth:self isNextMonth:isNextMonth];
    }
}

#pragma mark - Setter
- (void)setShowDate:(NSString *)showDate {
    _showDate = showDate;
    _showDateLabel.text = showDate;
}

#pragma mark - Getter
- (UILabel*)showDateLabel {
    if (!_showDateLabel) {
        _showDateLabel = [UILabel new];
        _showDateLabel.backgroundColor = [UIColor colorWithHexString:@"00b5b3"];
        _showDateLabel.textColor = [UIColor whiteColor];
        _showDateLabel.font = [UIFont boldSystemFontOfSize:14];
        _showDateLabel.textAlignment = NSTextAlignmentCenter;
        // 默认显示当前年月
        _showDateLabel.text = [[NSDate date] stringWithFormat:@"yyyy-MM"];
    }
    return _showDateLabel;
}

- (UIButton*)lastMonthButton {
    if (!_lastMonthButton) {
        _lastMonthButton = [UIButton new];
        _lastMonthButton.backgroundColor = [UIColor colorWithHexString:@"00b5b3"];
        [_lastMonthButton setImage:[UIImage imageNamed:@"calendar_left"] forState:UIControlStateNormal];
        [_lastMonthButton addTarget:self action:@selector(changeMonthAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lastMonthButton;
}

- (UIButton*)nextMonthButton {
    if (!_nextMonthButton) {
        _nextMonthButton = [UIButton new];
        _nextMonthButton.backgroundColor = [UIColor colorWithHexString:@"00b5b3"];
        [_nextMonthButton setImage:[UIImage imageNamed:@"calendar_right"] forState:UIControlStateNormal];
        [_nextMonthButton addTarget:self action:@selector(changeMonthAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextMonthButton;
}
@end
