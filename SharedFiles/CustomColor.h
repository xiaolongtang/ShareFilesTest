//
//  CustomColor.h
//  LeJu
//
//  Created by U箱超市 on 14-7-29.
//  Copyright (c) 2014年 姚琪. All rights reserved.
//自定义颜色

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define     BlueFontNormalColor             @"#17BFAB"
#define     BlueFontHighlightColor          @"#0CAF9C"

#define     GreenFontNormalColor            @"#98B926"
#define     GreenFontHighightColor          @"#7B9914"

#define     ViewCtlGeneralBackgroundColor   @"#E2E2E2"

#define     GeneralFontNormalColor          @"#282828"

#define     RedFontNormalColor              @"#FF2E00"

#define     BorderColor                     [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]

@interface CustomColor : NSObject

/**
 *  取得常用字体颜色
 *
 *  @return UIColor
 */
+ (UIColor *)colorForVI;

/**
 *  根据十六进制颜色值构造UIColor
 *
 *  @param string #eeffff/eeffff/0xeeffff
 *
 *  @return UIColor
 */
+ (UIColor *)colorForHexString:(NSString *)string;

+ (UIColor *)titleColor;

+ (UIColor *)storeNameColor;

+ (UIColor *)fontGrayColor;

@end
