//
//  ShowDetailViewController.m
//  SharedFiles
//
//  Created by 晓龙 唐 on 15/12/11.
//  Copyright © 2015年 txl. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "EditorViewController.h"

@interface ShowDetailViewController ()
{
    UIWebView    *webView;
}

@end

@implementation ShowDetailViewController

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
//        self.navView.image = [UIImage imageNamed:@"nav_bar1"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navTitle=_tTitle;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTitle:_tTitle];
    
    UIButton* storeDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    storeDetailButton.frame = CGRectMake(0, 0, 60, 20);
    storeDetailButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [storeDetailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [storeDetailButton setTitle:@"编辑" forState:UIControlStateNormal];
    [storeDetailButton addTarget:self action:@selector(rightNavButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:storeDetailButton];

    
    webView=[[UIWebView alloc]initWithFrame:self.factView.bounds];
    NSString* url = [[[XLGetBaseSetting sharedBaseSetting] xlBaseSetting] objectForKey:@"Base URL"];
    url = [url stringByAppendingString:@"ShareFileIpad/page.jsp?id="];
    url=[NSString stringWithFormat:@"%@%@",url,_idStr];
 
     NSURLRequest *request =[NSURLRequest requestWithURL:
                             [NSURL URLWithString:url]];
    [self.factView addSubview: webView];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rightNavButtonClick{
    EditorViewController *ctl=[[EditorViewController alloc]init];
    ctl.idStr=_idStr;
    [self.navigationController pushViewController:ctl animated:YES];
}

@end
