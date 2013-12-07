//
//  UserInfoEntity.h
//  SinaMBlogNimbus
//
//  Created by jimneylee on 13-2-22.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "JLNimbusEntity.h"
#import "SMUserInfoEntity.h"

@interface SMUserInfoEntity : JLNimbusEntity

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *profileImageUrl;

@end
