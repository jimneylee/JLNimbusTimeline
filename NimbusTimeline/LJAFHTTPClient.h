//
//  SNAPIClient.h
//  SinaMBlogNimbus
//
//  Created by jimneylee on 13-7-25.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "AFHTTPClient.h"

@interface LJAFHTTPClient : AFHTTPClient

+ (LJAFHTTPClient*)sharedClient;

// GET refresh else load cache
- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        refresh:(BOOL)refresh
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
