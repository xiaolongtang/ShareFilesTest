//
//  XLGetBaseSetting.h
//  WaiMaiKu
//
//  Created by U箱超市 on 14/11/6.
//  Copyright (c) 2014年 xiaolu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLGetBaseSetting : NSObject

+ (XLGetBaseSetting *) sharedBaseSetting;

@property (nonatomic, strong)   NSDictionary*       xlBaseSetting;

@property (nonatomic, copy)     NSString*           wmk_AppAdress;

@property (nonatomic, assign)   NSInteger           wmk_orderNumber;

@property (nonatomic, assign)   NSInteger           wmk_msgNumber;

@property (nonatomic, assign)   NSInteger           wmk_score;

@property (nonatomic, assign)   CGFloat             wmk_money;

@property (nonatomic, copy)     NSString*           duibaLoginUrl;

@end
