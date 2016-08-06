//
//  UXTableView.h
//  UXiang
//
//  Created by 胡 少敏 on 13-12-17.
//  Copyright (c) 2013年 胡 少敏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, MyTableViewStatusViewType)
{
    MYTableStatusViewReadyDown,
    MYTableStatusViewWillStopDown,
    MYTableStatusViewUpdating,
    MYTableStatusViewMoreLoading,
    MYTableStatusViewNothing,
    MYTableStatusViewEnded
};

@interface MyTableView : UITableView

@property (nonatomic, assign) MyTableViewStatusViewType status;
@property (nonatomic, assign) CGFloat                   contentInsetTop;
@property (nonatomic, assign) CGFloat                   contentInsetBottom;
@property (nonatomic, assign) BOOL                      needsRefresh;
@property (nonatomic, assign) BOOL                      needsLoadMore;

- (id) initWithFrame:(CGRect)frame needsRefresh:(BOOL)needsRefresh needsLoadMore:(BOOL)needsLoadMore style:(UITableViewStyle)style;

- (void) updateStatusViewBy:(MyTableViewStatusViewType)status;

- (void) tableViewDidDragging;

- (MyTableViewStatusViewType) tableViewDidEndDragging;

- (void) reloadData:(BOOL)animated;

@end
