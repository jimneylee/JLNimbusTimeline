//
//  SMStatusEntity.m
//  SinaMBlogNimbus
//
//  Created by jimneylee on 13-1-30.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "SMStatusEntity.h"
#import "SMJSONKeys.h"
#import "NSString+StringValue.h"
#import "NSDate+formatDateFromString.h"

@implementation SMStatusEntity

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithDictionary:(NSDictionary*)dic
{
    if (!dic.count || ![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    self = [super initWithDictionary:dic];
    if (self) {
        self.user = (SMUserInfoEntity *)[SMUserInfoEntity entityWithDictionary:dic[JSON_STATUS_USER]];
        self.text = dic[JSON_STATUS_TEXT];
        self.source = [self getSourceString:dic[JSON_STATUS_SOURCE]];
        self.created_at = dic[JSON_STATUS_CREATED_AT];
        self.timestamp = [NSDate formatDateFromString:self.created_at];
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+(SMBaseEntity *) entityWithDictionary:(NSDictionary *)dic {
    if (!dic.count || ![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    SMStatusEntity *entity = [[SMStatusEntity alloc] initWithDictionary:dic];    
    return entity;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//<a href="http://app.weibo.com/t/feed/40zIsF" rel="nofollow">谈微博</a>
- (NSString*)getSourceString:(NSString*)htmlSource
{
    NSRange range1 = [htmlSource rangeOfString:@"\">"];
    NSRange range2 = [htmlSource rangeOfString:@"/a>"];
    NSRange sourceRange = NSMakeRange(range1.location + range1.length,
                                      range2.location - (range1.location + range1.length) - 1);
    NSString* source = [htmlSource substringWithRange:sourceRange];
    return [NSString stringWithFormat:@"来自%@", source];
}

@end
