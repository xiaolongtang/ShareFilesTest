//
//  ViewController.m
//  SharedFiles
//
//  Created by 晓龙 唐 on 15/12/7.
//  Copyright © 2015年 txl. All rights reserved.
//

#import "ViewController.h"
#import "ShowDetailViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView                 *tableView;
    NSMutableArray              *titleList;
    NSMutableArray              *tIDList;
}

@end

@implementation ViewController

- (id) init
{
    
    self = [self initWithViewCtlType:MvcontrollerTypeNav];
    
    //    [self setEnableDefaultNavLeftButton]; //左返回
//        UIButton* storeDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        storeDetailButton.frame = CGRectMake(0, 0, 30, 20);
//        storeDetailButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [storeDetailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [storeDetailButton setTitle:@"提交" forState:UIControlStateNormal];
//        [storeDetailButton addTarget:self action:@selector(rightNavButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [self setRightNavButton:storeDetailButton];
    
    return self;
}

- (id) initWithViewCtlType:(MyViewCtlType)type
{
    if (self = [super initWithViewCtlType:type])
    {
        self.tableview.hidden = YES;
//        self.navigationController.navigationBar.tintColor=[UIColor clearColor];
//        self.navView.image = [UIImage imageNamed:@"nav_bar1"];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setTitle:@"课程列表"];
    

    tableView=[[UITableView alloc]initWithFrame:self.factView.bounds style:UITableViewStylePlain];
//    tableView.bounces=NO;
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [self.factView addSubview:tableView];
    
//    [self getPostList];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getPostList)];
    
    // 马上进入刷新状态
    [tableView.header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    tableView.backgroundColor=[UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView
#pragma UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleList count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell*) tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSString *CellIdentifier = @"Cell";
    
        UITableViewCell *cell = (UITableViewCell*)[tableView1  dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *l=[[UILabel alloc]init];
    l.text=[titleList objectAtIndex:indexPath.row];
    l.textColor=[UIColor redColor];
    [cell.contentView addSubview:l];
    [l makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(50);
        make.width.equalTo(400);
        make.top.equalTo(20);
        make.height.equalTo(40);
        
    }];
    
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowDetailViewController *ctl=[[ShowDetailViewController alloc]init];
    ctl.tTitle=[titleList objectAtIndex:indexPath.row];
    ctl.idStr=[tIDList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:ctl animated:YES];
}

#pragma request
-(void) getPostList{
    titleList=[[NSMutableArray alloc]init];
    tIDList=[[NSMutableArray alloc]init];
    
    
//    NSString *url=@"http://192.168.1.103:8080/ShareFileIpad/json.action";
    NSString* url = [[[XLGetBaseSetting sharedBaseSetting] xlBaseSetting] objectForKey:@"Base URL"];
    url = [url stringByAppendingString:@"ShareFileIpad/json.htm"];
    [[CustomHttpRequest sharedRequest] GET_FromPath:url parameters:@{} succeed:^(id json) {
        NSArray* list = (NSArray *)[json objectForKey:@"PostList"];
        if (list && list.count)
        {
            for (int i=0; i<list.count; i++)
            {
                NSDictionary* dict = list[i];
                NSString *title=[dict objectForKey:@"title"];
                NSString *tIDStr=[dict objectForKey:@"id"];
                
                [titleList addObject:title];
                
                [tIDList addObject:tIDStr];
                
                [tableView reloadData];
                
                [tableView.header endRefreshing];
            }
        }
    
    } failured:^(NSError *error, id json) {}];
}

//-(void)getPostList{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    // 原本需要拼接get访问URL ? & =
//    NSDictionary *dict = @{};
//    
//    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
//    [manager GET:@"http://192.168.1.103:8080/ShareFileIpad/json.htm" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
//        // 提问:NSURLConnection异步方法回调,是在子线程
//        // 得到回调之后,通常更新UI,是在主线程
//        NSLog(@"%@", [NSThread currentThread]);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
//    }];
//}
@end
