//
//  UserInfoEntity.m
//  SinaMBlogNimbus
//
//  Created by jimneylee on 13-2-22.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "SMUserInfoEntity.h"
#import "SMJSONKeys.h"
#import "NSString+StringValue.h"
#import "SMStatusEntity.h"

@implementation SMUserInfoEntity

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithDictionary:(NSDictionary*)dic
{
    if (!dic.count || ![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    self = [super initWithDictionary:dic];
    if (self) {
        self.name = dic[JSON_USERINFO_NAME];
        self.profileImageUrl = dic[JSON_USERINFO_PROFILE_IMAGE_URL];
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (SMUserInfoEntity *)entityWithDictionary:(NSDictionary *)dic {
    if (!dic.count || ![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    SMUserInfoEntity *entity = [[SMUserInfoEntity alloc] initWithDictionary:dic];   
    return entity;
}

@end
