//
//  MyBaseViewController.m
//  Parking
//
//  Created by Waimaiku on 15/1/24.
//  Copyright (c) 2015年 Xiaolong Tang. All rights reserved.
//

#import "MyBaseViewController.h"

#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES1/gl.h>
#import "CustomColor.h"

#define IS_OS_7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

@interface MyBaseViewController ()<UINavigationControllerDelegate>
{
    UILabel*                    titleLabel;
}

@property(nonatomic, strong)    UIToolbar*              botCategoryTool;

@end

@implementation MyBaseViewController

- (id) init{
    if (self = [super init])
    {
        
    }
    return self;
}

- (id) initWithViewCtlType:(MyViewCtlType)type
{
    if (self = [super init])
    {
        //        CCLOG(@"Screen:%f.%f",SCREEN_WIDTH,SCREEN_HEIGHT);
        [self.navigationController setNavigationBarHidden:YES];
        
        switch (type)
        {
            case MvcontrollerTypeNone:
            {
                CGRect rect = [UIScreen mainScreen].bounds;
                if (!IS_OS_7_OR_LATER)
                {
                    rect.size.height -= STATUS_HEIGHT;
                }
                self.factView = [[UIView alloc] initWithFrame:rect];
                
                [self.view addSubview:self.factView];
            }
                break;
            case MvcontrollerTypeNav:
            {
                CGRect rect = [UIScreen mainScreen].bounds;
                rect.size.height -= STATUS_HEIGHT+NAV_HEIGHT;
                if (!IS_OS_7_OR_LATER)
                {
                    
                }
                else
                {
                    rect.origin.y += STATUS_HEIGHT+NAV_HEIGHT;
                }
                self.factView = [[UIView alloc] initWithFrame:rect];
                
                _navView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, IS_OS_7_OR_LATER?NAV_HEIGHT+STATUS_HEIGHT:NAV_HEIGHT)];
                [self.view addSubview:_navView];
                _navView.userInteractionEnabled = YES;
                //                _navView.backgroundColor = [CustomColor colorForHexString:@"#ED4042"];
                //                CCLOG(@"[Nav-Height:%f]",_navView.bounds.size.height);
                
                [self.view addSubview:self.factView];
            }
                break;
            case MvcontrollerTypeTab:
            {
                CGRect rect = [UIScreen mainScreen].bounds;
                rect.size.height -= TAB_HEIGHT;
                if (!IS_OS_7_OR_LATER)
                {
                    
                }
                self.factView = [[UIView alloc] initWithFrame:rect];
                
                _botImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
                [self.view addSubview:_botImgView];
                
                [self.view addSubview:self.factView];
            }
                break;
            case MvcontrollerTypeTaNav:
            {
                CGRect rect = [UIScreen mainScreen].bounds;
                rect.size.height -= STATUS_HEIGHT+NAV_HEIGHT+TAB_HEIGHT;
                if (!IS_OS_7_OR_LATER)
                {
                    
                }
                else
                {
                    rect.origin.y += STATUS_HEIGHT+NAV_HEIGHT;
                }
                self.factView = [[UIView alloc] initWithFrame:rect];
                
                _navView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, IS_OS_7_OR_LATER?NAV_HEIGHT+STATUS_HEIGHT:NAV_HEIGHT)];
                [self.view addSubview:_navView];
                _navView.userInteractionEnabled = YES;
                _navView.backgroundColor = [CustomColor colorForHexString:@"#ED4042"];
                //                CCLOG(@"[Nav-Height:%f]",_navView.bounds.size.height);
                
                _botImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
                [self.view addSubview:_botImgView];
                
                [self.view addSubview:self.factView];
            }
                break;
                
            default:
                break;
        }
        
        //        CCLOG(@"[FaceView:[%f,%f,%f,%f]]",CGRectGetMinX(_factView.frame),CGRectGetMinY(_factView.frame),CGRectGetWidth(_factView.bounds),CGRectGetHeight(_factView.bounds));
        //        self.factView.backgroundColor = [UIColor orangeColor];
        self.tableview = [[MyTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_factView.bounds), CGRectGetHeight(_factView.bounds)) needsRefresh:YES needsLoadMore:YES style:UITableViewStylePlain];
        [self.factView addSubview:self.tableview];
        self.tableview.backgroundColor = [UIColor whiteColor];
        if(IS_OS_7_OR_LATER)
        {
            [self.tableview setSeparatorInset:UIEdgeInsetsZero];
        }
        
        self.factView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void) initBotCategoryBar
{
    self.botCategoryTool = [[UIToolbar alloc] initWithFrame:CGRectMake(-1, self.factView.bounds.size.height-49, SCREEN_WIDTH+2, 50)];
    [self.botCategoryTool.layer setBorderWidth:1];
    [self.botCategoryTool.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.factView addSubview:self.botCategoryTool];
    self.botCategoryTool.hidden = NO;
    
    NSArray* botNameArray = @[@"排序", @"分类", @"配送"];
    CGFloat width = SCREEN_WIDTH/3;
    for (int i=0; i<3; i++)
    {
        NSString* title = [botNameArray objectAtIndex:i];
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake(1+i*width, 0, width, 49);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        [_botCategoryTool addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(categoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) showBotCategoryBar
{
    self.botCategoryTool.hidden = NO;
    [UIView animateWithDuration:0.4 animations:^{
        self.botCategoryTool.frame = CGRectMake(-1, self.factView.bounds.size.height-49, SCREEN_WIDTH+2, 50);
    } completion:^(BOOL finished) {
        self.botCategoryTool.hidden = NO;
    }];
}

- (void) hideBotCategoryBar
{
    [UIView animateWithDuration:0.4 animations:^{
        self.botCategoryTool.frame = CGRectMake(-1, self.factView.bounds.size.height, SCREEN_WIDTH+2, 50);
    } completion:^(BOOL finished) {
        self.botCategoryTool.hidden = YES;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (IS_OS_7_OR_LATER)
    {
        //        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        //        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (IS_OS_7_OR_LATER)
    {
        //        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        //        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setEnableDefaultNavLeftButton
{
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    leftButton.frame = CGRectMake(0, 0, 30, 30);
    //    [leftButton setBackgroundImage:[UIImage imageNamed:@"Left Reveal Icon"] forState:UIControlStateNormal];
    
    //    leftButton.frame = CGRectMake(0, 0, 22.5, 22.5);
    leftButton.frame = CGRectMake(8, 0, 9.5, 18.5);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(goBackLastViewCtl:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setLeftNavButton:leftButton];}

- (void) setEnableDefaultNavRightButton
{
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 22.5, 22.5);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"btnSearch"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightNavButton:rightButton];
}

#pragma mark    setter

- (void) setLeftNavButton:(UIButton *)leftNavButton
{
    if (_leftNavButton)
    {
        [_leftNavButton removeFromSuperview];
        _leftNavButton = leftNavButton;
    }
    
    if (!leftNavButton)
    {
        return ;
    }
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, leftNavButton.bounds.size.width+40, 44)];
    [btn addTarget:self action:@selector(goBackLastViewCtl:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:btn];
    
    CGRect rect = leftNavButton.bounds;
    //修改退回按钮往左
    rect.origin.x = 12;
    rect.origin.y = IS_OS_7_OR_LATER?(NAV_HEIGHT-rect.size.height)/2+20:(NAV_HEIGHT-rect.size.height)/2;
    leftNavButton.frame = rect;
    [self.navView addSubview:leftNavButton];
    
    //    [self.view sendSubviewToBack:_factView];
}

- (void) setRightNavButton:(UIButton *)rightNavButton
{
    if (_rightNavButton)
    {
        [_rightNavButton removeFromSuperview];
        _rightNavButton = rightNavButton;
    }
    
    if (!rightNavButton)
    {
        return ;
    }
    
    CGRect rect = rightNavButton.bounds;
    rect.origin.x = SCREEN_WIDTH-20-rect.size.width;
    rect.origin.y = IS_OS_7_OR_LATER?(NAV_HEIGHT-rect.size.height)/2+18:(NAV_HEIGHT-rect.size.height)/2;
    rightNavButton.frame = rect;
    [self.navView addSubview:rightNavButton];
    
    //    [self.view sendSubviewToBack:_factView];
}

- (void) setTitleView:(UIView *)titleView
{
    titleView.center = CGPointMake(_navView.bounds.size.width/2, _navView.bounds.size.height/2);
    [self.navView addSubview:titleView];
    
    //    [self.view sendSubviewToBack:_factView];
}

//- (void) setNavView:(UIImageView *)navView
//{
//
//}

- (void) setNavTitle:(NSString *)navTitle
{
    if (!titleLabel)
    {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240, 30)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.numberOfLines = 0;
        
        titleLabel.center = CGPointMake(_navView.bounds.size.width/2, _navView.bounds.size.height/2+10);
        [self.navView addSubview:titleLabel];
    }
    
    titleLabel.text = navTitle;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark    button click

- (void) goBackLastViewCtl:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) rightButtonClick:(id)sender
{
    if ([self respondsToSelector:@selector(rightNavButtonClick)])
    {
        [self rightNavButtonClick];
    }
}


- (void) categoryButtonClick:(UIButton *)sender
{
    if ([self respondsToSelector:@selector(botCategoryButtonClick:)])
    {
        [self botCategoryButtonClick:sender];
    }
}

- (void) botCategoryButtonClick:(UIButton *)btn
{
    //override
}

- (void) rightNavButtonClick
{
    
}


#pragma mark    屏幕截图
-(UIImage *) glToUIImage {
    /*
     NSInteger myDataLength = SCREEN_WIDTH * SCREEN_HEIGHT * 4;
     
     // allocate array and read pixels into it.
     GLubyte *buffer = (GLubyte *) malloc(myDataLength);
     glReadPixels(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
     
     // gl renders "upside down" so swap top to bottom into new array.
     // there's gotta be a better way, but this works.
     NSInteger count = SCREEN_WIDTH;
     NSInteger limit = SCREEN_HEIGHT;
     GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
     for(int y = 0; y <limit; y++)
     {
     for(int x = 0; x <count * 4; x++)
     {
     buffer2[(limit-1 - y) * count * 4 + x] = buffer[y * 4 * count + x];
     }
     }
     
     // make data provider with data.
     CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, NULL);
     
     // prep the ingredients
     int bitsPerComponent = 8;
     int bitsPerPixel = 32;
     int bytesPerRow = 4 * SCREEN_WIDTH;
     CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
     CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
     CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
     
     // make the cgimage
     CGImageRef imageRef = CGImageCreate(SCREEN_WIDTH, SCREEN_HEIGHT, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
     
     // then make the uiimage from that
     UIImage *myImage = [UIImage imageWithCGImage:imageRef];
     UIImage *yourImage = [UIImage new];
     UIImage* resultImage = [self mergerImage:myImage secodImage:yourImage];
     
     return resultImage;
     */
    NSInteger myDataLength = 1024 * 768 * 4;  //1024-width，768-height
    
    // allocate array and read pixels into it.
    GLubyte *buffer = (GLubyte *) malloc(myDataLength);
    glReadPixels(0, 0, 1024, 768, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    
    // gl renders "upside down" so swap top to bottom into new array.
    // there's gotta be a better way, but this works.
    GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
    for(int y = 0; y <768; y++)
    {
        for(int x = 0; x <1024 * 4; x++)
        {
            buffer2[(767 - y) * 1024 * 4 + x] = buffer[y * 4 * 1024 + x];
        }
    }
    
    // make data provider with data.
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, NULL);
    
    // prep the ingredients
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * 1024;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    // make the cgimage
    CGImageRef imageRef = CGImageCreate(1024, 768, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    
    // then make the uiimage from that
    UIImage *myImage = [UIImage imageWithCGImage:imageRef];
    return myImage;
}

//合并图片
-(UIImage *)mergerImage:(UIImage *)firstImage secodImage:(UIImage *)secondImage
{
    CGSize imageSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    UIGraphicsBeginImageContext(imageSize);
    
    [firstImage drawInRect:CGRectMake(0, 0, firstImage.size.width, firstImage.size.height)];
    [secondImage drawInRect:CGRectMake(0, 0, secondImage.size.width, secondImage.size.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}


@end
