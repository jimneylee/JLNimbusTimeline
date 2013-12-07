//
//  SNAPIClient.h
//  SinaMBlogNimbus
//
//  Created by jimneylee on 13-7-25.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "JLAFHTTPClient.h"

@interface SMAPIClient : JLAFHTTPClient

+ (SMAPIClient*)sharedClient;

// public timeline
+ (NSString*)relativePathForPublicTimelineWithPageCounter:(NSInteger)pageCounter
                                             perpageCount:(NSInteger)perpageCount;

@end

NSString *const kSMAPIBaseURLString;