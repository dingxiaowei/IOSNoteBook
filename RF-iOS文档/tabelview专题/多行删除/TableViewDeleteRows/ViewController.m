
#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _table;
    BOOL _isEidt;//判断table是否进入编辑状态
    NSMutableArray * _deleteArr;//存放要删除的数据
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //数据初始化
    _deleteArr = [NSMutableArray arrayWithCapacity:0];
    
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<20; i++) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
        [dic setObject:[NSNumber numberWithBool:NO] forKey:@"State"];
        [dic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"Content"];
        [self.dataArr addObject:dic];
    }
    //做一个Btn控制编辑状态和删除数据等操作
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.tag = 1000;
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn setTitle:@"删除" forState:UIControlStateSelected];
    btn.selected = NO;
    btn.frame = CGRectMake(0, 0, 320, 30);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //初始化table
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
}

//实现btn点击事件
-(void)btnClick:(UIButton *)button
{
    //btn的选中状态置反
    button.selected = !button.selected;
    //table的编辑状态置反
    _isEidt = !_isEidt;
    //设置table的编辑状态
    [_table setEditing:_isEidt];
    //删除选中数据
    if (!_isEidt) {
        [self.dataArr removeObjectsInArray:_deleteArr];
        [_table reloadData];
        [_deleteArr removeAllObjects];
    }
}
#pragma mark table相关协议方法实现
//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
//返回cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //复用机制
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    //给cell的textLabel赋值
    cell.textLabel.text = self.dataArr[indexPath.row][@"Content"];
    return cell;
}
//返回编辑方式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //返回多行选择
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
//已选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //修改数据状态为可删除
    [self.dataArr[indexPath.row] setObject:[NSNumber numberWithBool:YES] forKey:@"State"];
    //将选中数据放入存放删除数据的数组中
    [_deleteArr addObject:self.dataArr[indexPath.row]];
}
//取消选中
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //修改数据状态为不可删除
    [self.dataArr[indexPath.row] setObject:[NSNumber numberWithBool:NO] forKey:@"State"];
    //将以存放在删除数组中的数据移除
    [_deleteArr removeObject:self.dataArr[indexPath.row]];
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
