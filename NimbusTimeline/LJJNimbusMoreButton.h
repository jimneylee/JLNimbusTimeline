//
//  NILoadMoreFooterView.h
//  NimbusTimeline
//
//  Created by jimneylee on 13-10-21.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJJNimbusMoreButton : UIButton

@property (nonatomic, strong) UILabel* textLabel;
@property (nonatomic, strong) UIActivityIndicatorView* activityIndicatorView;
@property (nonatomic, assign) BOOL animating;
@property (nonatomic, copy) NSString* loadingTitle;
@property (nonatomic, copy) NSString* moreTitle;
@property (nonatomic, strong) UIFont* titleFont;

+ (id)defaultMoreButton;

@end
