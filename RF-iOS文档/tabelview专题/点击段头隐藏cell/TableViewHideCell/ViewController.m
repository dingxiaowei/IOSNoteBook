//
//  ViewController.m
//  TableViewHideCell
//
//  Created by qianfeng on 14-7-27.
//  Copyright (c) 2014年 QF. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _table;
}
@property(nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化数据
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    //数组套字典，字典再套数组
    for (int i = 'A'; i<='P'; i++) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
        [dic setObject:[NSNumber numberWithBool:YES] forKey:@"State"];
        NSMutableArray * subArr = [NSMutableArray arrayWithCapacity:0];
        for (int j = 0; j<5; j++) {
            [subArr addObject:[NSString stringWithFormat:@"%d",j+1]];
        }
        [dic setObject:subArr forKey:@"Content"];
        [self.dataArr addObject:dic];
    }
    //初始化table
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

#pragma mark table协议实现
//返回段数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}
//返回段头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
//根据State状态返回每段cell行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary * dic = self.dataArr[section];
    if ([dic[@"State"] boolValue]) {
        return 0;
    }else{
        return [self.dataArr[section][@"Content"] count];
    }
}
//返回cell及设置cell内容
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = self.dataArr[indexPath.section][@"Content"][indexPath.row];
    return cell;
}
//返回自定义段头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, 320, 30);
    [btn setTitle:[NSString stringWithFormat:@"第%c段-->咦~我打开了，吼吼~~",'A'+section] forState:UIControlStateNormal];
    [btn setTitle:[NSString stringWithFormat:@"第%c段-->来，戳我，戳我~~",'A'+section] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 10000+section;
    btn.selected = [self.dataArr[section][@"State"] boolValue];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn.tintColor = [UIColor whiteColor];
    if (section%2) {
        btn.backgroundColor = [UIColor lightGrayColor];
    }else
    {
        btn.backgroundColor = [UIColor grayColor];
    }
    return btn;
}//实现段头Btn的事件方法
-(void)btnClick:(UIButton *)button
{
    button.selected = !button.selected;
    if ([self.dataArr[button.tag-10000][@"State"] boolValue]) {
        [self.dataArr[button.tag - 10000] setObject:[NSNumber numberWithBool:NO] forKey:@"State"];
    }else{
        [self.dataArr[button.tag - 10000] setObject:[NSNumber numberWithBool:YES] forKey:@"State"];
    }
    //刷新段
    [_table reloadSections:[NSIndexSet indexSetWithIndex:button.tag-10000] withRowAnimation:UITableViewRowAnimationFade];
    if (![self.dataArr[button.tag-10000][@"State"] boolValue]) {
        //滚动到最后一行
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:4 inSection:button.tag -10000];
        [_table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
//隐藏状态条
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
