//
//  CustomHttpRequest.h
//  MyCustomTemplate
//
//  Created by U箱超市 on 14-9-19.
//  Copyright (c) 2014年 xiaolu. All rights reserved.
// 一般网络请求处理类

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

#import "UIKit+AFNetworking.h"

/**
 *  自定义的HTTP请求类，包含Get和Post请求两种
 */
@interface CustomHttpRequest : NSObject

+ (CustomHttpRequest *) sharedRequest;

//request

/**
 *  GET
 */
- (void) GET_FromPath:(NSString *)path parameters:(NSDictionary *)parameters succeed:(void(^)(id json))success failured:(void(^)(NSError* error, id json))failure;

/**
 *  POST URL-Form-Encoded
 */
- (void) POSTUFE_FromPath:(NSString *)path parameters:(NSDictionary *)parameters succeed:(void(^)(id json))success failured:(void(^)(NSError* error, id json))failure;

/**
 *  POST Muti-Part
 */
- (void) POSTMP_FromPath:(NSString *)path parameters:(NSDictionary *)parameters succeed:(void(^)(id json))success failured:(void(^)(NSError* error, id json))failure;

@end
