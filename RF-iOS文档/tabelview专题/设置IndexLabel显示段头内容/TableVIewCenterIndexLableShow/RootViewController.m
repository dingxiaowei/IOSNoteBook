
#import "RootViewController.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _table;
    UILabel * _indexLabel;
}

@property(nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //初始化数据
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        for (int section = 'A'; section <='Z'; section++) {
            NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
            for (int i = 0; i<5; i++) {
                [arr addObject:[NSString stringWithFormat:@"%d",(section-'A')*5+i+1]];
            }
            [self.dataArr addObject:arr];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建一个tableview
	_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    //设置要显示段头的label
    _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    //得到self.view的中心点坐标
    CGPoint point = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    //让label的中心点等于其父视图的中心点
    _indexLabel.center = point;
    _indexLabel.backgroundColor = [UIColor blackColor];
    _indexLabel.font = [UIFont systemFontOfSize:48];
    _indexLabel.textColor = [UIColor whiteColor];
    _indexLabel.textAlignment = NSTextAlignmentCenter;
    _indexLabel.hidden = YES;
    [self.view addSubview:_indexLabel];
}
#pragma mark tableView相关协议方法
//返回段头内容
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%c",'A'+section];
}
//返回段行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}
//返回每段有多少行Cell--必须实现的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
}
//Cell复用及添加内容--必须实现的协议方法
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell的复用机制
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];//从标示符为ID的cell复用队列中取出一个cell
    if (cell == nil) {
        //如果ID队列中没有可用的cell，就创建一个cell，并加上复用标示符
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    //给cell添加内容
    cell.textLabel.text = [self.dataArr[indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}
#pragma mark scrollView相关协议方法
//视图即将开始滚动
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    //显示之前隐藏的label
    _indexLabel.hidden = NO;
    //设置label的透明度
    _indexLabel.alpha = 0.5;
}
//视图已经开始滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //indexlabel的中心点相对于表格视图的坐标点是多少
    CGPoint point = [_table convertPoint:_indexLabel.center fromView:self.view];
    //通过point得到label中心点在那个cell上，取得cell的indexPath
    NSIndexPath * indexPath = [_table indexPathForRowAtPoint:point];
    //根据获得的indexPath，修改label.text的值
    _indexLabel.text = [NSString stringWithFormat:@"%c",'A'+indexPath.section];
}
//视图结束滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //隐藏label
    _indexLabel.hidden = YES;
}
#pragma mark 隐藏状态条
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
