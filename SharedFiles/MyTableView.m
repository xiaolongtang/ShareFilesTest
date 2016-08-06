//
//  UXTableView.m
//  UXiang
//
//  Created by 胡 少敏 on 13-12-17.
//  Copyright (c) 2013年 胡 少敏. All rights reserved.
//

#import "MyTableView.h"

@interface MyTableView()
{
    UIView *headerStatusView;
    UIView *footerStatusView;
    
    UILabel *headerStatusTipsLabel;
    UILabel *footerStatusTipsLabel;
    
    UIActivityIndicatorView *headerStatusIndicator;
    UIActivityIndicatorView *footerStatusIndicator;
    
    UIImageView *iconView;
    UIView *iconBackgourndView;
    
    CGFloat initPaddingTop;
}

- (void)initialization;

@end

@implementation MyTableView

@synthesize status = _status;
@synthesize contentInsetTop = _contentInsetTop;
@synthesize contentInsetBottom = _contentInsetBottom;
@synthesize needsLoadMore = _needsLoadMore;
@synthesize needsRefresh = _needsRefresh;

CGFloat const statusViewHeight = 50.f;
- (id)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame needsRefresh:(BOOL)needsRefresh needsLoadMore:(BOOL)needsLoadMore style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _needsRefresh = needsRefresh;
        _needsLoadMore = needsLoadMore;

        [self initialization];
    }
    return self;
}

- (void)initialization
{
    _contentInsetTop = 0;
    _contentInsetBottom = 0;
    CGFloat tableWidth = self.frame.size.width;

    if (_needsRefresh)
    {
        headerStatusView = [[UIView alloc] init];
        headerStatusView.backgroundColor = [UIColor clearColor];
        
        
        headerStatusView.frame = CGRectMake(0, -statusViewHeight, tableWidth, statusViewHeight);
        
        iconBackgourndView = [[UIView alloc] init];
        iconBackgourndView.backgroundColor =[UIColor clearColor];
        [headerStatusView addSubview:iconBackgourndView];
        
        headerStatusTipsLabel               = [[UILabel alloc] init];
        headerStatusTipsLabel.frame         = CGRectMake(0, 20.f, tableWidth, 20.f);
        headerStatusTipsLabel.text          = @"下拉更新";
        headerStatusTipsLabel.textColor     = [UIColor grayColor];
        headerStatusTipsLabel.textAlignment = NSTextAlignmentCenter;
        headerStatusTipsLabel.font          = [UIFont systemFontOfSize:13.f];
        [headerStatusView addSubview:headerStatusTipsLabel];
        
        iconView       = [[UIImageView alloc] init];
        iconView.backgroundColor = [UIColor redColor];
        iconView.frame = CGRectMake(tableWidth / 2 - 52.f  , 20.f, 25.f, 20.f);
        iconView.image = [UIImage imageNamed:@"iconRefresh"];
        [headerStatusView addSubview:iconView];
        
        headerStatusIndicator                  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        headerStatusIndicator.frame            = CGRectMake(tableWidth / 2 - 52.f  , 20.f, 20.f, 20.f);
        headerStatusIndicator.hidesWhenStopped = YES;
        [headerStatusView addSubview:headerStatusIndicator];
        
        [self addSubview:headerStatusView];
    }
    
    if (_needsLoadMore)
    {
        footerStatusView                    = [[UIView alloc] init];
        footerStatusView.frame              = CGRectMake(0, 0, tableWidth, statusViewHeight);
        footerStatusTipsLabel               = [[UILabel alloc] init];
        footerStatusTipsLabel.text          = @"上拉加载更多";
        footerStatusTipsLabel.frame         = CGRectMake(0, 5, tableWidth, 30.f);
        footerStatusTipsLabel.textColor     = [UIColor grayColor];
        footerStatusTipsLabel.textAlignment = NSTextAlignmentCenter;
        footerStatusTipsLabel.font          = [UIFont systemFontOfSize:13.f];
        [footerStatusView addSubview:footerStatusTipsLabel];
        
        footerStatusIndicator                  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        footerStatusIndicator.frame            = CGRectMake(tableWidth / 2 - 52.f  , 10, 20.f, 20.f);
        footerStatusIndicator.hidesWhenStopped = YES;
        [footerStatusView addSubview:footerStatusIndicator];
        [self setTableFooterView:footerStatusView];
    }
}

- (void) updateStatusViewBy:(MyTableViewStatusViewType)status
{
    _status = status;
    switch (_status)
    {
        case MYTableStatusViewReadyDown:
            headerStatusTipsLabel.text  = @"下拉更新";
            [headerStatusIndicator stopAnimating];
            iconView.hidden = NO;
            break;
        case MYTableStatusViewWillStopDown:
            headerStatusTipsLabel.text = @"释放更新";
            iconBackgourndView.frame = CGRectMake(iconView.frame.origin.x, iconView.frame.origin.y, 25, 20.f);
            [headerStatusIndicator stopAnimating];
            iconView.hidden = NO;
            break;
        case MYTableStatusViewUpdating:
            headerStatusTipsLabel.text = @"正在更新";
            iconBackgourndView.frame = CGRectZero;
            [headerStatusIndicator startAnimating];
            iconView.hidden = YES;
            break;
        case MYTableStatusViewMoreLoading:
            footerStatusTipsLabel.text = @"正在加载";
            [footerStatusIndicator startAnimating];
            break;
        case MYTableStatusViewEnded:
            footerStatusTipsLabel.text = @"已加载所有商品";
            [footerStatusIndicator stopAnimating];
            break;
        case MYTableStatusViewNothing:
            footerStatusTipsLabel.text = @"上拉加载更多";
            [footerStatusIndicator stopAnimating];
            break;
        default:
            break;
    }
}

- (void) tableViewDidDragging
{
    if (_status == MYTableStatusViewUpdating ||
        _status == MYTableStatusViewMoreLoading)
    {
        return;
    }
    
    CGFloat contentInsetTop = self.contentInset.top;
    CGFloat offsetY = self.contentOffset.y + contentInsetTop;
    
    if (_needsRefresh)
    {
        if (offsetY < - statusViewHeight) {
            [self updateStatusViewBy:MYTableStatusViewWillStopDown];
        } else
        {
            if (offsetY < -40)
            {
                CGFloat delta = MIN(40,  -offsetY - 40);
                iconBackgourndView.frame = CGRectMake(iconView.frame.origin.x, iconView.frame.origin.y, 25, delta);
            }
            [self updateStatusViewBy:MYTableStatusViewReadyDown];
        }
    }
}

- (MyTableViewStatusViewType) tableViewDidEndDragging
{
    if (_status == MYTableStatusViewUpdating ||
        _status == MYTableStatusViewMoreLoading)
    {
        return MYTableStatusViewNothing;
    }
    
    CGFloat offsetY = self.contentOffset.y;

    if (_needsRefresh && offsetY < - statusViewHeight)
    {
        [self updateStatusViewBy:MYTableStatusViewUpdating];
        self.contentInset = UIEdgeInsetsMake(statusViewHeight + _contentInsetTop, 0, _contentInsetBottom, 0);
        return MYTableStatusViewUpdating;
    }
    
    CGFloat differenceY = self.contentSize.height > self.frame.size.height ? (self.contentSize.height - self.frame.size.height) : 0;

    if (_needsLoadMore && offsetY >  differenceY + statusViewHeight / 2 - _contentInsetBottom)
    {
        [self updateStatusViewBy:MYTableStatusViewMoreLoading];
        self.contentInset = UIEdgeInsetsMake(_contentInsetTop, 0, _contentInsetBottom + statusViewHeight, 0);
        return MYTableStatusViewMoreLoading;
    }
    return MYTableStatusViewNothing;
}

- (void) reloadData:(BOOL)hasMore;
{
    [self reloadData];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    self.contentInset = UIEdgeInsetsMake(_contentInsetTop, 0, _contentInsetBottom, 0);
    [UIView commitAnimations];
    
    if (_needsRefresh)
    {
        [self updateStatusViewBy:MYTableStatusViewReadyDown];
    }

    if (_needsLoadMore)
    {
        [self updateStatusViewBy:( hasMore ? MYTableStatusViewNothing : MYTableStatusViewEnded)];
    }
}

@end
