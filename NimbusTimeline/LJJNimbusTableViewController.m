//
//  LJJBaseTableC.m
//  SkyNet
//
//  Created by jimneylee on 13-7-29.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "LJJNimbusTableViewController.h"
#import "LJJNimbusMoreButton.h"

#ifndef IOS_IS_AT_LEAST_7
#define IOS_IS_AT_LEAST_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#endif

#define DEFAULT_PULL_DOWN_REFRESH_DURATION 0.25f
#define DEFAULT_DRAG_UP_BOTTOM_OFFSET 30
#define DEFAULT_DELAY_PULL_DOWN_RELOAD_DURATION 1.f

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface LJJNimbusTableViewController ()
@property (nonatomic, strong) LJJNimbusMoreButton* loadMoreFooterView;
@property (nonatomic, assign) BOOL autoPullDownLoading;
@end

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation LJJNimbusTableViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _cellFactory = [[NICellFactory alloc] init];
        _model = [[[self tableModelClass] alloc] initWithDelegate:_cellFactory];
        _actions = [[NITableViewActions alloc] initWithTarget:self];
        [self.actions attachToClass:[self.model objectClass] tapBlock:self.tapAction];
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView
{
    [super loadView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshAction)
                  forControlEvents:UIControlEventValueChanged];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self.model;
    self.tableView.delegate = [self.actions forwardingTo:self];
    
    [self performSelector:@selector(autoPullDownReloadActionAnimaton)
               withObject:nil afterDelay:DEFAULT_DELAY_PULL_DOWN_RELOAD_DURATION];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)autoPullDownReloadActionAnimaton
{
    if (!self.autoPullDownLoading) {
        [self pullDownLoadingAnimation];
        [self reloadAction];
        self.autoPullDownLoading = YES;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)autoPullDownRefreshActionAnimation
{
    if (!self.autoPullDownLoading) {
        [self pullDownLoadingAnimation];
        [self refreshAction];
        self.autoPullDownLoading = YES;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showMessageForEmpty
{
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showMessageForError
{
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showMssageForLastPage
{
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createLoadMoreFooterView
{
    LJJNimbusMoreButton* loadMoreFooterView = [LJJNimbusMoreButton defaultMoreButton];
    [loadMoreFooterView addTarget:self action:@selector(loadMoreAction)
                 forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = loadMoreFooterView;
    self.loadMoreFooterView = loadMoreFooterView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)reloadAction
{
    [self.refreshControl beginRefreshing];
    [self refreshData:NO];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)refreshAction
{
    [self.refreshControl beginRefreshing];
    [self refreshData:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadMoreAction
{
    [self loadMoreData];
    [self.loadMoreFooterView setAnimating:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)refreshData:(BOOL)refresh
{
    if (self.refreshControl.refreshing) {
        [self didBeginLoadData];
        [self.model loadDataWithBlock:^(NSArray* indexPaths, NSError* error) {
            if (indexPaths) {
                if (indexPaths.count) {
                    [self.tableView reloadData];
                }
                else {
                    [self showMessageForEmpty];
                }
                
                [self didFinishLoadData];
            }
            else {
                [self showMessageForError];
                [self didFailLoadData];
            }
            [self.refreshControl endRefreshing];
            self.autoPullDownLoading = NO;
            [self finishLoadingAnimation];
        } more:NO refresh:refresh];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadMoreData
{
    [self.model loadDataWithBlock:^(NSArray* indexPaths, NSError* error) {
        if (indexPaths.count) {
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
            [self didFinishLoadData];
        }
        else {
            [self didFailLoadData];
            
            if (error) {
                [self showMessageForError];
            }
            else {
                [self showMssageForLastPage];
            }
        }
        [self.loadMoreFooterView setAnimating:NO];
    } more:YES refresh:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)pullDownLoadingAnimation
{
    CGFloat height = - self.refreshControl.frame.size.height;
    if (IOS_IS_AT_LEAST_7 && self.navigationController.navigationBar.translucent) {
        CGFloat navigationBarBottom = (self.navigationController.navigationBar.origin.y
                                       + self.navigationController.navigationBar.frame.size.height);
        height = - (navigationBarBottom + self.refreshControl.frame.size.height);
    }
    
    [UIView animateWithDuration:DEFAULT_PULL_DOWN_REFRESH_DURATION
                          delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^(void){
                              self.tableView.contentOffset = CGPointMake(0.f, height);
                          } completion:NULL];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)finishLoadingAnimation
{
    CGFloat height = 0.0f;
    if (IOS_IS_AT_LEAST_7 && self.navigationController.navigationBar.translucent) {
        CGFloat navigationBarBottom = (self.navigationController.navigationBar.origin.y
                                       + self.navigationController.navigationBar.frame.size.height);
        
        height = - navigationBarBottom;//bottom
    }
    [UIView animateWithDuration:DEFAULT_PULL_DOWN_REFRESH_DURATION delay:0.f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^(void){
                            self.tableView.contentOffset = CGPointMake(0.f, height);
                            [self.refreshControl endRefreshing];
                        } completion:NULL];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Override

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NIActionBlock)tapAction
{
    return ^BOOL(id object, id target, NSIndexPath *indexPath) {
        return YES;
    };
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)tableModelClass
{
    return [LJJNimbusTableModel class];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didBeginLoadData
{
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didFinishLoadData
{
    if (self.model.hasMoreEntity) {
        if (!self.loadMoreFooterView ) {
            [self createLoadMoreFooterView];
        }
    }
    else {
        if (self.loadMoreFooterView) {
            self.tableView.tableFooterView = nil;
            self.loadMoreFooterView = nil;
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didFailLoadData
{
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellFactory tableView:tableView heightForRowAtIndexPath:indexPath model:self.model];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIScrollViewDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.loadMoreFooterView) {
        CGFloat endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (scrollView.contentSize.height > scrollView.frame.size.height
            && endScrolling >= scrollView.contentSize.height + DEFAULT_DRAG_UP_BOTTOM_OFFSET) {
            [self loadMoreAction];
        }
    }
}

@end
