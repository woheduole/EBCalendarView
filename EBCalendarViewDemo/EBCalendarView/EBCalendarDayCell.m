//
//  EBCalendarDayCell.m
//  EBCalendarViewDemo
//
//  Created by HoYo on 2018/4/26.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import "EBCalendarDayCell.h"
#import "UIColor+EBAdd.h"
#import "EBCalendarModel.h"

@interface EBCalendarDayCell()
@property (nonatomic, strong) UILabel *dayLabel;
@end
CGFloat const EBCalendarDayCellDayWidth = 25;
@implementation EBCalendarDayCell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self setupFrame];
    }
    return self;
}

#pragma mark - Setup

- (void)setupView {
    [self.contentView addSubview:self.dayLabel];
}

- (void)setupFrame {
    _dayLabel.frame = CGRectMake(CGRectGetWidth(self.contentView.bounds) / 2 - EBCalendarDayCellDayWidth / 2
                                 , CGRectGetHeight(self.contentView.bounds) / 2 - EBCalendarDayCellDayWidth / 2
                                 , EBCalendarDayCellDayWidth
                                 , EBCalendarDayCellDayWidth);
}

#pragma mark - Public
- (void)configWithCalendarModel:(EBCalendarModel*)model {
    // 上月的数据显示为空，并且不能点击
    if(model.year == 0) {
        _dayLabel.text = @"";
    }else {
        _dayLabel.text = @(model.day).stringValue;
    }
    
    [self styleOfNormalDay];
    
    if (model.isSelected) {
        [self styleOfSelectedDay];
    }
    if (model.isToday) {
        [self styleOfToday];
    }
}

#pragma mark Private
- (void)styleOfSelectedDay {
    _dayLabel.layer.masksToBounds = YES;
    _dayLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _dayLabel.layer.borderColor = [UIColor colorWithHexString:@"11e0a5"].CGColor;
}

- (void)styleOfToday {
    _dayLabel.layer.masksToBounds = YES;
    _dayLabel.backgroundColor = [UIColor colorWithHexString:@"11e0a5"];
    _dayLabel.textColor = [UIColor whiteColor];
    _dayLabel.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)styleOfNormalDay {
    _dayLabel.backgroundColor = [UIColor whiteColor];
    _dayLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _dayLabel.layer.cornerRadius = EBCalendarDayCellDayWidth * 0.5;
    _dayLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    _dayLabel.layer.borderWidth = 1;
    _dayLabel.layer.masksToBounds = NO;
}
#pragma mark Getter
- (UILabel*)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [UILabel new];
        _dayLabel.font = [UIFont systemFontOfSize:13];
        _dayLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dayLabel;
}
@end
