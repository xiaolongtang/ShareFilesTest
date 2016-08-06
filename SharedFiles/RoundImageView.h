//
//  RoundImageView.h
//  iOSTest
//
//  Created by lzz on 13-11-19.
//  Copyright (c) 2013年 sowin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundImageView : UIView
{
    float       imageOffset; //矩形边长与圆半径之差(内切圆的偏移值)
}

@property(nonatomic, retain) UIImage*       image;

@end
