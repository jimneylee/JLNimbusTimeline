//
//  SNAPIClient.h
//  SinaMBlogNimbus
//
//  Created by jimneylee on 13-7-25.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "JLAFAPIBaseClient.h"

@interface SMAPIClient : JLAFAPIBaseClient

+ (SMAPIClient *)sharedClient;

// public timeline
+ (NSString*)relativePathForPublicTimelineWithPageCounter:(NSInteger)pageCounter
                                             perpageCount:(NSInteger)perpageCount;

@end

NSString *const kSMAPIBaseURLString;