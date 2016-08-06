//
//  XLGetBaseSetting.m
//  WaiMaiKu
//
//  Created by U箱超市 on 14/11/6.
//  Copyright (c) 2014年 xiaolu. All rights reserved.
//

#import "XLGetBaseSetting.h"

@implementation XLGetBaseSetting

- (id) init
{
    if (self = [super init])
    {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
        self.xlBaseSetting = [NSDictionary dictionaryWithContentsOfFile:path];
        CCLOG(@"%@",_xlBaseSetting);
    }
    
    return self;
}

+ (XLGetBaseSetting *) sharedBaseSetting
{
    static XLGetBaseSetting* instance = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        instance = [[XLGetBaseSetting alloc] init];
    });
    
    return instance;
}

@end
