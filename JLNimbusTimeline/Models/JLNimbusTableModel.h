//
//  NITimelineTableModel.h
//  NimbusTimeline
//
//  Created by Lee jimney on 7/27/13.
//  Copyright (c) 2013 jimneylee. All rights reserved.
//

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface JLNimbusTableModel : NIMutableTableViewModel

@property (nonatomic, assign) BOOL hasMoreData;
@property (nonatomic, assign) NSInteger pageCounter;
@property (nonatomic, assign) NSInteger perpageCount;

- (Class)objectClass;
- (Class)cellClass;
- (void)loadDataWithBlock:(void(^)(NSArray* items, NSError *error))block
                     more:(BOOL)more refresh:(BOOL)refresh;

@end
