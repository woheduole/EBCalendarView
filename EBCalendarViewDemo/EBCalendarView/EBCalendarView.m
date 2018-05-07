//
//  EBCalendarView.m
//  EBCalendarViewDemo
//
//  Created by HoYo on 2018/4/25.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import "EBCalendarView.h"
#import "EBCalendarDayCell.h"
#import "EBCalenderWeekView.h"
#import "EBCalenderNavigationView.h"
#import "NSDate+EBAdd.h"
#import "UIColor+EBAdd.h"

@interface EBCalendarView()<UICollectionViewDataSource, UICollectionViewDelegate, EBCalenderNavigationViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) EBCalenderWeekView *weekView;
@property (nonatomic, strong) EBCalenderNavigationView *navigationView;
@property (nonatomic, strong) NSArray *dates;
@property (nonatomic, assign) NSInteger currentYear, currentMonth;
@property (nonatomic, strong) NSDate *selectedDate;
@end

static NSString *const kEBCalendarViewReuseIdentifier = @"EBCalendarDayCell";
// 周视图高度
static CGFloat const kEBCalendarViewWeekViewHeight = 35;
// 左右导航视图高度
static CGFloat const kEBCalenderNavigationViewHeight = 40;
// Cell高度
static CGFloat const kEBCalendarViewCellHeight = 35;
// 列数
static CGFloat const kEBCalendarViewCellColumn = 7.0;
@implementation EBCalendarView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self dataBuilder];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupFrame];
}
#pragma mark - Setup
- (void)setupView {
    [self addSubview:self.navigationView];
    [self addSubview:self.weekView];
    [self addSubview:self.collectionView];
    
    
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [_collectionView addGestureRecognizer:leftGesture];
    
    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [_collectionView addGestureRecognizer:rightGesture];
}

- (void)setupFrame {
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    _navigationView.frame = CGRectMake(0, 0, viewWidth, kEBCalenderNavigationViewHeight);
    _weekView.frame = CGRectMake(0, CGRectGetMaxY(_navigationView.frame), viewWidth, kEBCalendarViewWeekViewHeight);
    _collectionView.frame = CGRectMake(0, CGRectGetMaxY(_weekView.frame), viewWidth, CGRectGetHeight(self.bounds) - kEBCalendarViewWeekViewHeight);
    _flowLayout.itemSize = CGSizeMake(viewWidth / kEBCalendarViewCellColumn, kEBCalendarViewCellHeight);
}

#pragma mark - Private
- (void)handleSwipeGesture:(UISwipeGestureRecognizer *)recognizer {
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        // 上个月
        [self calenderNavigationViewDidChangeMonth:_navigationView isNextMonth:YES];
    }
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        // 下个月
        [self calenderNavigationViewDidChangeMonth:_navigationView isNextMonth:NO];
    }
}

- (void)dataBuilder {
    _maxLastMonths = -1;
    _maxNextMonths = -1;
    [self createMonthData:[NSDate date]];
    // 周数据
    _weekView.weeks = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
}

- (void)createMonthData:(NSDate*)date {
    _currentYear = date.year;
    _currentMonth = date.month;
    _navigationView.showDate = [date stringWithFormat:@"yyyy-MM"];
    NSMutableArray *datasource = [NSMutableArray new];
    // 当前月第一天
    NSDate *firstDayOfMonth = [NSDate dateWithString:[NSString stringWithFormat:@"%zd-%zd-01"
                                                      , _currentYear
                                                      , _currentMonth] format:@"yyyy-MM-dd"];
    // 当前月的总天数
    NSUInteger days = firstDayOfMonth.numberOfDaysInMonth;
    // 当前月第一天周几，1是周日
    NSInteger weekday = firstDayOfMonth.weekday - 1;
    // -1之后周日会变成0
    if (weekday == 0) {
        weekday = 7;
    }
    // 填充上月的空数据
    for (int n = 1; n < weekday; n++) {
        EBCalendarModel *model = [EBCalendarModel new];
        [datasource addObject:model];
    }
    // 填充本月的日期
    for (int n = 1; n <= days; n ++) {
        EBCalendarModel *model = [EBCalendarModel new];
        model.year = _currentYear;
        model.month = _currentMonth;
        model.day = n;
        if ([model.date isToday]) {
            model.today = YES;
        }
        [datasource addObject:model];
    }
    _dates = [datasource copy];
    [_collectionView reloadData];
    
    // 小数向上取整
    NSInteger rows = ceilf(_dates.count / kEBCalendarViewCellColumn);
    self.frame = ({
        CGRect frame = self.frame;
        frame.size.height = kEBCalendarViewWeekViewHeight + kEBCalenderNavigationViewHeight + (rows * kEBCalendarViewCellHeight);
        frame;
    });
}


#pragma mark - UICollectionViewDataSource and UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dates.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EBCalendarDayCell *cell = (EBCalendarDayCell*)[collectionView dequeueReusableCellWithReuseIdentifier:kEBCalendarViewReuseIdentifier forIndexPath:indexPath];
    EBCalendarModel *model = _dates[indexPath.row];
    // 月份切换时回显之前选中的日期状态
    if (_selectedDate && [model.date isEqual:_selectedDate]) {
        model.selected = YES;
    }
    [cell configWithCalendarModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EBCalendarModel *model = _dates[indexPath.row];
    // 上月的数据显示为空，并且不能点击
    if(model.year == 0) return;
    [_dates setValue:@"NO" forKey:@"selected"];
    [collectionView reloadData];
    _selectedDate = model.date;
    if ([self.delegate respondsToSelector:@selector(calendarView:didSelectedDate:)]) {
        [self.delegate calendarView:self didSelectedDate:model.date];
    }
}


#pragma mark - EBCalenderNavigationViewDelegate
- (void)calenderNavigationViewDidChangeMonth:(EBCalenderNavigationView *)calenderNavigationView isNextMonth:(BOOL)isNextMonth {
    NSInteger addMonths = 1;
    if (!isNextMonth) {
        addMonths = -1;
    }
    NSDate *date = [[NSDate dateWithString:[NSString stringWithFormat:@"%zd-%zd-01"
                                            , _currentYear
                                            , _currentMonth] format:@"yyyy-MM-dd"] dateByAddingMonths:addMonths];
    if (_maxLastMonths >= 0) {
        NSDate *maxLastMonthDate = [[NSDate dateWithString:[NSString stringWithFormat:@"%zd-%zd-01"
                                                            , [NSDate date].year
                                                            , [NSDate date].month] format:@"yyyy-MM-dd"] dateByAddingMonths:-_maxLastMonths];
        if ([maxLastMonthDate compare:date] > 0 ) return;
    }
    
    if (_maxNextMonths >= 0) {
        NSDate *maxNextMonthDate = [[NSDate dateWithString:[NSString stringWithFormat:@"%zd-%zd-01"
                                                            , [NSDate date].year
                                                            , [NSDate date].month] format:@"yyyy-MM-dd"] dateByAddingMonths:_maxNextMonths];
        if ([maxNextMonthDate compare:date] < 0 ) return;
    }
    
    [self createMonthData:date];
}


#pragma mark - Getter
- (UICollectionViewFlowLayout*)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.minimumInteritemSpacing = 0;//cell 左右间距
        _flowLayout.minimumLineSpacing = 0;//cell 上下间距
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[EBCalendarDayCell class] forCellWithReuseIdentifier:kEBCalendarViewReuseIdentifier];
    }
    return _collectionView;
}

- (EBCalenderNavigationView*)navigationView {
    if (!_navigationView) {
        _navigationView = [EBCalenderNavigationView new];
        _navigationView.delegate = self;
    }
    return _navigationView;
}

- (EBCalenderWeekView*)weekView {
    if (!_weekView) {
        _weekView = [EBCalenderWeekView new];
        _weekView.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    }
    return _weekView;
}


@end
