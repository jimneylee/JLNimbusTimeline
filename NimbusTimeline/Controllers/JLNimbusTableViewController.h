//
//  NITimelineTableViewController.h
//  NimbusTimeline
//
//  Created by jimneylee on 13-7-29.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "JLNimbusTableModel.h"

@interface JLNimbusTableViewController : UITableViewController

@property (nonatomic, assign) NITableViewActionBlock tapAction;
@property (nonatomic, strong) JLNimbusTableModel* model;
@property (nonatomic, strong) NITableViewActions* actions;
@property (nonatomic, strong) NICellFactory* cellFactory;

- (void)autoPullDownRefreshActionAnimation;
- (void)didBeginLoadData;
- (void)didFinishLoadData;
- (void)didFailLoadData;

@end
