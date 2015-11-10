//
//  ChatTableView.m
//  ChatTest
//
//  Created by null on 11/6/15.
//  Copyright © 2015 null. All rights reserved.
//

#import "ChatTableView.h"

@implementation ChatTableView
{
    UITableView *_table;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self addTableView];
    return self;
}


#pragma mark -- notification 添加
- (void)addNotification {
    
}

#pragma mark -- tableview 表格处理
- (void)addTableView {
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) style:UITableViewStylePlain];
    [_table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_table setDelegate:self];
    [_table setDataSource:self];
    
    [self addSubview:_table];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
