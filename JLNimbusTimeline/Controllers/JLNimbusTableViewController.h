//
//  NITimelineTableViewController.h
//  NimbusTimeline
//
//  Created by jimneylee on 13-7-29.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "JLNimbusTableModel.h"
#import "JLNimbusMoreButton.h"

@interface JLNimbusTableViewController : UITableViewController

@property (nonatomic, assign) NITableViewActionBlock tapAction;
@property (nonatomic, strong) JLNimbusTableModel* model;
@property (nonatomic, strong) NITableViewActions* actions;
@property (nonatomic, strong) JLNimbusMoreButton* loadMoreFooterView;;
@property (nonatomic, assign) BOOL isCacheFirstLoad;
           
- (void)autoPullDownRefreshActionAnimation;
- (void)refreshData:(BOOL)refresh;
- (void)loadMoreAction;
- (void)reloadWithIndexPaths:(NSArray*)indexPaths;
- (void)loadMoreWithIndexPaths:(NSArray*)indexPaths;
- (void)didBeginLoadData;
- (void)didFinishLoadData;
- (void)didFailLoadData;

@end
