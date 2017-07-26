//
//  BPNetRequest.m
//  
//
//  Created by 金晓沛 on 4/8/17.
//  Copyright © 2017 YYQG. All rights reserved.
//

#import "BPNetRequest.h"
#import "AppDelegate.h"

@interface BPNetRequest ()

@property (nonatomic, assign) MDYNetworkMethod wRequestType;

@end

@implementation BPNetRequest

+ (BPNetRequest *)getInstance{
    static BPNetRequest *netRequest = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        netRequest = [[self alloc] init];
    });
    return netRequest;
}

- (AFHTTPSessionManager *)sharedManager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        manager.requestSerializer.timeoutInterval = 10;
    });
    return manager;
}

- (void)resetURL:(NSMutableString *)url Parameters:(NSMutableDictionary *)parameters {

    url.string = [StringFormat(@"%@%@",COMPANYURL, url) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
}


/**
 *  Get形式提交数据
 *
 *  @param urlString  Url
 *  @param parameters 参数
 *  @param success    成功Block
 *  @param fail       失败Block
 */
- (void)getJsonWithUrl:(NSString *)urlString
            parameters:(id)parameters
               success:(NetRequestSuccessBlock)success
                  fail:(NetRequestFailedBlock)fail
{
    AFHTTPSessionManager *manager = [self sharedManager];
    
    NSMutableDictionary *baseParameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    NSMutableString *url = [urlString mutableCopy];
    [self resetURL:url Parameters:baseParameters];
    [manager GET:url parameters:baseParameters  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [Helper hideLoading];
        if (success) {
            success(responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [Helper hideLoading];
//        [Helper showTip:error.localizedDescription];
        
        if (fail) {
            fail(error);
        }
    }];
}

/**
 *  Post形式提交数据
 *
 *  @param urlString  Url
 *  @param parameters 参数
 *  @param success    成功Block
 *  @param fail       失败Block
 */
- (void)postJsonWithUrl:(NSString *)urlString
             parameters:(id)parameters
                success:(NetRequestSuccessBlock)success
                   fail:(NetRequestFailedBlock)fail
{
    AFHTTPSessionManager *manager = [self sharedManager];
    
    NSMutableDictionary *baseParameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    NSMutableString *url = [urlString mutableCopy];
    [self resetURL:url Parameters:baseParameters];
    
    [manager POST:url parameters:baseParameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [Helper hideLoading];
        if (success) {
            success(responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [Helper hideLoading];
//        [Helper showTip:error.localizedDescription];
        
        if (fail) {
            fail(error);
        }
    }];
}

-(void)postDataWithUrl:(NSString *)urlString parameters:(id)parameters success:(NetRequestSuccessBlock)success fail:(NetRequestFailedBlock)fail
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(dictData);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail(error);
        NSLog(@"数据获取失败");
        NSLog(@"error111  %@",error.description);
    }];
}


-(void)getDataWithUrl:(NSString *)urlString parameters:(id)parameters success:(NetRequestSuccessBlock)success fail:(NetRequestFailedBlock)fail
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(dictData);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail(error);
        NSLog(@"数据获取失败");
        NSLog(@"error111  %@",error.description);
    }];
}

@end
