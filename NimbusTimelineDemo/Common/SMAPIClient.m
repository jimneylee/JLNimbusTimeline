//
//  SNAPIClient.m
//  SinaMBlogNimbus
//
//  Created by jimneylee on 13-7-25.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "SMAPIClient.h"
#import "AFJSONRequestOperation.h"
#import "AFImageRequestOperation.h"

NSString *const kSMAPIBaseURLString = @"https://api.weibo.com/2/";

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SMAPIClient

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (SMAPIClient*)sharedClient
{
    static SMAPIClient* _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SMAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kSMAPIBaseURLString]];
    });
    
    return _sharedClient;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self registerHTTPOperationClass:[AFImageRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - GET Request

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        refresh:(BOOL)refresh
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
	NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters];
    if (!refresh) {
        [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    }
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self enqueueHTTPRequestOperation:operation];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TimeLine

///////////////////////////////////////////////////////////////////////////////////////////////////
// public time api
// !note: page -> cusor
+ (NSString*)relativePathForPublicTimelineWithPageCounter:(NSInteger)pageCounter
                                             perpageCount:(NSInteger)perpageCount
{
    return [NSString stringWithFormat:@"statuses/public_timeline.json?cursor=%d&count=%d&source=%@",
            pageCounter, perpageCount, SinaWeiboAppKey];
}

@end
