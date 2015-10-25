
#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _table;
    UIView * _bgView;
    NSInteger _type;
    BOOL _isMove;
    BOOL _isEdit;
    BOOL _frameIsChange;
}
@property(strong,nonatomic)NSMutableArray * dataArr;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //关闭自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    //数据初始化
    _type = 0;
    _isMove = NO;
    _isEdit = NO;
    
    self.dataArr = [NSMutableArray array];
    for (int i = 0; i<20; i++) {
        NSString * str = [NSString stringWithFormat:@"第%d行",i];
        [self.dataArr addObject:str];
    }
    //给navigationBar添加两个按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(leftItemClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightItemClick)];
    //实例化tabel
	_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    //做一个下拉菜单
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    [self.view addSubview:_bgView];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    NSArray * arr = @[@"插入行",@"删除行",@"删除多行",@"移动行"];
    for (int i = 0; i<4; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(0+i*80, 34, 80, 30);
        btn.tag = 1000+i;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:btn];
        if (i>0) {
            UIView * strip = [[UIView alloc] initWithFrame:CGRectMake(80*i, 34, 1, 30)];
            strip.backgroundColor = [UIColor lightGrayColor];
            [_bgView addSubview:strip];
        }
        UIView * bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 63, 320, 1)];
        bottom.backgroundColor = [UIColor lightGrayColor];
        [_bgView addSubview:bottom];
    }
}
//实现下拉菜单的button事件
-(void)btnClick:(UIButton *)button
{
    switch (button.tag) {
        case 1000:
            _type = 2;
            break;
        case 1001:
            _type = 1;
            break;
        case 1002:
            _type = 3;
#warning 多行删除在这就不实现了，自己参考另外一个多行删除的工程
            break;
        case 1003:
            _isMove = YES;
            _type = 0;
            break;
        default:
            break;
    }
    [_table setEditing:YES];
    _bgView.frame = CGRectMake(0, 0, 320, 64);
    _table.frame = CGRectMake(0, 64, 320, self.view.bounds.size.height - 64);
}
//navgationbar左按键事件
-(void)leftItemClick
{
    _isEdit = !_isEdit;
    if (_isEdit) {
        _bgView.frame = CGRectMake(0, 34, 320, 64);
        _table.frame = CGRectMake(0, 64+30, 320, self.view.bounds.size.height - 64-30);
    }else{
        _bgView.frame = CGRectMake(0, 0, 320, 64);
        _table.frame = CGRectMake(0, 64, 320, self.view.bounds.size.height - 64);
    }
}
//navgationbar右按键事件
-(void)rightItemClick
{
    if (_isEdit) {
        [_table setEditing:NO];
        _bgView.frame = CGRectMake(0, 0, 320, 64);
        _table.frame = CGRectMake(0, 64, 320, self.view.bounds.size.height - 64);
        _isEdit = !_isEdit;
    }
}
#pragma mark table协议实现
//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
//返回cell及内容
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
//返回编辑方式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _type;
}
//具体编辑方法实现
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==1) {
        [self.dataArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    if (editingStyle ==2) {
        NSString * str = @"new";
        [self.dataArr insertObject:str atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
//返回是否可移动
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _isMove;
}
//变更移动后的数组内容及UI显示
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString * str = self.dataArr[sourceIndexPath.row];
    [self.dataArr removeObjectAtIndex:sourceIndexPath.row];
    [self.dataArr insertObject:str atIndex:destinationIndexPath.row];
}

@end
