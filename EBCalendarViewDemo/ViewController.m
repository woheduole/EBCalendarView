//
//  ViewController.m
//  EBCalendarViewDemo
//
//  Created by HoYo on 2018/4/25.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import "ViewController.h"
#import "EBCalendarView.h"
#import "NSDate+EBAdd.h"
@interface ViewController ()<EBCalendarViewDelegate>
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, weak) EBCalendarView *calendarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    EBCalendarView *calendarView = [[EBCalendarView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 0)];
    calendarView.delegate = self;
    //calendarView.maxLastMonths = 0;  
    //calendarView.maxNextMonths = 0;
    [self.view addSubview:calendarView];
    _calendarView = calendarView;
    
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 75, CGRectGetMaxY(calendarView.frame), 150, 20)];
    _dateLabel.text = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_dateLabel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _dateLabel.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 75, CGRectGetMaxY(_calendarView.frame), 150, 20);
}
#pragma mark - EBCalendarViewDelegate
- (void)calendarView:(EBCalendarView*)calendarView didSelectedDate:(NSDate*)date {
    NSLog(@"选中日期:%@", [date stringWithFormat:@"yyyy-MM-dd"]);
    _dateLabel.text = [date stringWithFormat:@"yyyy-MM-dd"];
}

@end
