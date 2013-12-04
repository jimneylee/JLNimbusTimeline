//
//  SMStatusEntity.h
//  SinaMBlogNimbus
//
//  Created by jimneylee on 13-1-30.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMBaseEntity.h"
#import "SMUserInfoEntity.h"

@interface SMStatusEntity : SMBaseEntity

@property (nonatomic, strong) SMUserInfoEntity *user;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, strong) NSDate *timestamp;

@end
