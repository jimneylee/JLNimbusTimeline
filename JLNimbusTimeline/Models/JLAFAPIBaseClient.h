//
//  JLAFHTTPRequestOperationManager.h
//  JLNimbusTimeline
//
//  Created by jimneylee on 13-7-25.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface JLAFAPIBaseClient : AFHTTPRequestOperationManager

+ (JLAFAPIBaseClient *)sharedClient;

// GET refresh else load cache
- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    refresh:(BOOL)refresh
    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// Cancel request with path
- (void)cancelAllHTTPOperationsWithPath:(NSString *)path;

@end
