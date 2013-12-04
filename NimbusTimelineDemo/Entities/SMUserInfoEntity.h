//
//  UserInfoEntity.h
//  SinaMBlogNimbus
//
//  Created by jimneylee on 13-2-22.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "SMBaseEntity.h"
#import "SMUserInfoEntity.h"

@interface SMUserInfoEntity : SMBaseEntity

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *profileImageUrl;

@end
