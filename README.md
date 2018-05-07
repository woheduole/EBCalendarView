# EBCalendarView
CalendarView for iOS


# 调用示例

```
    EBCalendarView *calendarView = [[EBCalendarView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 0)];
    calendarView.delegate = self;
    //calendarView.maxLastMonths = 0;  
    //calendarView.maxNextMonths = 0;
    [self.view addSubview:calendarView];
```

```
- (void)calendarView:(EBCalendarView*)calendarView didSelectedDate:(NSDate*)date {
    NSLog(@"选中日期:%@", [date stringWithFormat:@"yyyy-MM-dd"]);
}
```
