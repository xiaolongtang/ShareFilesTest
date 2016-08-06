//
//  CustomHttpRequest.m
//  MyCustomTemplate
//
//  Created by U箱超市 on 14-9-19.
//  Copyright (c) 2014年 xiaolu. All rights reserved.
//

#import "CustomHttpRequest.h"

@interface CustomHttpRequest ()
{
    AFHTTPRequestOperationManager*              manager;
}

@end

@implementation CustomHttpRequest

- (id) init
{
    if (self = [super init])
    {
        manager = [AFHTTPRequestOperationManager manager];
    }
    
    return self;
}

+ (CustomHttpRequest *) sharedRequest
{
    static CustomHttpRequest* instance = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        instance = [[CustomHttpRequest alloc] init];
    });
    
    return instance;
}


#pragma mark    HTTP Request Operation Manager

//GET
- (void) GET_FromPath:(NSString *)path parameters:(NSDictionary *)parameters succeed:(void(^)(id json))success failured:(void(^)(NSError* error, id json))failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [param setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"version"];
//    [param setObject:@"2" forKey:@"userRefer"];
    
    [manager GET:path parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        CCLOG(@"[GET:%@]:%@",operation.request,responseObject);
        if ([[responseObject valueForKey:@"code"] intValue]==-1)
        {
            NSString* msg = [responseObject valueForKey:@"msg"];
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return ;
        }
        
        if (![responseObject valueForKey:@"code"])
        {
            success(responseObject);
            
            return ;
        }
        
        success([responseObject valueForKey:@"data"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        CCLOG(@"[GET:%@]:%@",operation.request,error);
    }];
    
}

//POST URL-Form-Encoded
- (void) POSTUFE_FromPath:(NSString *)path parameters:(NSDictionary *)parameters succeed:(void(^)(id json))success failured:(void(^)(NSError* error, id json))failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [param setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"version"];
//    [param setObject:@"2" forKey:@"userRefer"];
    
    [manager POST:path parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        CCLOG(@"[POST URL-Form-Encoded:%@]:%@",operation.request,responseObject);
        if ([[responseObject valueForKey:@"code"] intValue]==-1)
        {
            NSString* msg = [responseObject valueForKey:@"msg"];
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return ;
        }
        
        if (![responseObject valueForKey:@"code"])
        {
            success(responseObject);
            
            return ;
        }
        
        success([responseObject valueForKey:@"data"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        CCLOG(@"[POST URL-Form-Encoded:%@]:%@",operation.request,error);
    }];
    
}

//POST Muti-Part
- (void) POSTMP_FromPath:(NSString *)path parameters:(NSDictionary *)parameters succeed:(void(^)(id json))success failured:(void(^)(NSError* error, id json))failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [param setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"version"];
    
    [manager POST:path parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //        [formData appendPartWithFileData:data name:@"userFaceFile" fileName:@"face" mimeType:@"image/png"];
        //        [param removeObjectForKey:@"userFaceFile"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        CCLOG(@"[POSTMP:%@]:%@",operation.request,responseObject);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        CCLOG(@"[POSTMP:%@]:%@",operation.request,error);
    }];
    //    AFNetworkReachabilityStatus
}

@end
