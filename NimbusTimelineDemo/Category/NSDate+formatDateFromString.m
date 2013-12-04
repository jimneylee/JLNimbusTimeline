//
//  NSDate+SinaMBlog.m
//  SinaMBlogNimbus
//
//  Created by jimneylee on 13-10-31.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "NSDate+formatDateFromString.h"

@implementation NSDate (formatDateFromString)

+ (NSDate *)formatDateFromString:(NSString *)str {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss '+0800' yyyy"];
    return [dateFormatter dateFromString:str];
}

@end
