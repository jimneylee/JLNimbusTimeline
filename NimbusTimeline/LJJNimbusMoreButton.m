//
//  NILoadMoreFooterButton.m
//  NimbusTimeline
//
//  Created by jimneylee on 13-10-21.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "LJJNimbusMoreButton.h"

#define MORE_BUTTON_HEIGHT 55
#define DEFAULT_TITLE_FONT_SIZE 14.f
#define DEFAULT_LOADING_TITLE  @"加载中..."
#define DEFAULT_MORE_TITLE @"上拉显示更多"

@interface LJJNimbusMoreButton()
@end
@implementation LJJNimbusMoreButton

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)defaultMoreButton
{
    LJJNimbusMoreButton* moreBtn =
    [[LJJNimbusMoreButton alloc] initWithFrame:CGRectMake(0.f, 0.f,
                                                          [[UIScreen mainScreen] bounds].size.width,
                                                          MORE_BUTTON_HEIGHT)];
    moreBtn.backgroundColor = [UIColor clearColor];
    moreBtn.loadingTitle = DEFAULT_LOADING_TITLE;
    moreBtn.moreTitle = DEFAULT_MORE_TITLE;
    moreBtn.titleFont = [UIFont systemFontOfSize:DEFAULT_TITLE_FONT_SIZE];
    return moreBtn;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews
{
	[super layoutSubviews];
    self.textLabel.frame = self.bounds;
    self.activityIndicatorView.center =
    CGPointMake(self.frame.size.width - self.activityIndicatorView.frame.size.width - CELL_PADDING_8 * 2,
                self.textLabel.center.y);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIActivityIndicatorView*)activityIndicatorView
{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                                  UIActivityIndicatorViewStyleGray];

        [self addSubview:_activityIndicatorView];
    }
    
    return _activityIndicatorView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = self.titleFont;
        _textLabel.textColor = [UIColor grayColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.text = self.moreTitle;
        [self addSubview:_textLabel];
    }
    return _textLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setAnimating:(BOOL)animating {
    if (_animating != animating) {
        _animating = animating;
        
        if (_animating) {
            [self.activityIndicatorView startAnimating];
        }
        else {
            [self.activityIndicatorView stopAnimating];
        }
        [self changeLoadStatus];
        [self setNeedsLayout];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)changeLoadStatus
{
    self.textLabel.text = _animating ? self.loadingTitle : self.moreTitle;
}

@end
