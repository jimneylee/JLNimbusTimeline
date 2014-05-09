//
//  JLAFHTTPRequestOperationManager.m
//  JLNimbusTimeline
//
//  Created by jimneylee on 13-7-25.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "JLAFAPIBaseClient.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation JLAFAPIBaseClient

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (JLAFAPIBaseClient*)sharedClient
{
    // no need create shared instance, do this in subclass
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)cancelAllHTTPOperationsWithPath:(NSString *)path
{
    NSArray *operations = self.operationQueue.operations;
    
    for (AFHTTPRequestOperation *operation in operations) {
        
        NSString *url = [[operation.request.URL baseURL] absoluteString];
        NSRange range = [url rangeOfString:path];
        
        if (range.location != NSNotFound) {
            [operation cancel];
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - GET Request

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    refresh:(BOOL)refresh
    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    // follow code is copied from super implement
    //[self GET:path parameters:parameters success:success failure:failure];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    if (!refresh) {
        [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    }
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
}

@end
