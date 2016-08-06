//
//  MyBaseViewController.h
//  Parking
//
//  Created by Waimaiku on 15/1/24.
//  Copyright (c) 2015年 Xiaolong Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableView.h"

#define NAV_HEIGHT          44
#define TAB_HEIGHT          49
#define STATUS_HEIGHT       20

#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSUInteger, MyViewCtlType){
    MvcontrollerTypeNone,
    MvcontrollerTypeNav,
    MvcontrollerTypeTab,
    MvcontrollerTypeTaNav
};


@interface MyBaseViewController : UIViewController <UIGestureRecognizerDelegate>

/**
 *  导航栏
 */
@property(nonatomic, strong)    UIImageView*    navView;

/**
 *  导航栏左边按钮
 */
@property(nonatomic, strong)    UIButton*       leftNavButton;

/**
 *  导航栏右边按钮
 */
@property(nonatomic, strong)    UIButton*       rightNavButton;

/**
 *  导航栏中间视图
 */
@property(nonatomic, strong)    UIView*         titleView;

/**
 *  导航栏标题
 */
@property(nonatomic, copy)      NSString*       navTitle;

/**
 *  实际可用view
 */
@property(nonatomic, strong)    UIView*         factView;

/**
 *  默认的tableview
 */
@property(nonatomic, strong)    MyTableView*        tableview;

@property(nonatomic, strong)    UIImageView*        botImgView;

/**
 *  添加底部分类筛选
 */
- (void) initBotCategoryBar;

- (void) showBotCategoryBar;

- (void) hideBotCategoryBar;

- (void) botCategoryButtonClick:(UIButton*)btn; //sub method

/**
 *  启用默认的导航栏返回按钮
 */
- (void) setEnableDefaultNavLeftButton;

/**
 *  启用默认的导航栏右侧按钮
 */
- (void) setEnableDefaultNavRightButton;

/**
 *  导航栏左侧按钮点击
 */
- (void) goBackLastViewCtl:(id)sender;

/**
 *  导航栏右侧按钮点击
 */
- (void) rightNavButtonClick;


- (id) initWithViewCtlType:(MyViewCtlType)type;

-(UIImage *) glToUIImage;

@end
