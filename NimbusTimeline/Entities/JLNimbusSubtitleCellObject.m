//
//  JLNimbusSubtitleCellObject.m
//  SinaMBlogNimbus
//
//  Created by jimneylee on 13-1-31.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "JLNimbusSubtitleCellObject.h"

@implementation JLNimbusSubtitleCellObject

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithDictionary:(NSDictionary*)dic
{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.cellStyle = UITableViewCellStyleSubtitle;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)objectWithDictionary:(NSDictionary*)dic
{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    JLNimbusSubtitleCellObject* entity = [[JLNimbusSubtitleCellObject alloc] initWithDictionary:dic];
    return entity;
}

@end
