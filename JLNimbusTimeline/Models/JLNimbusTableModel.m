//
//  NITimelineTableModel.m
//  NimbusTimeline
//
//  Created by Lee jimney on 7/27/13.
//  Copyright (c) 2013 jimneylee. All rights reserved.
//

#import "JLNimbusTableModel.h"
#import "NITableViewModel+Private.h"
#import "NITableViewModel.h"
#import "JLNimbusEntity.h"

#define PERPAGE_COUNT 20
#define PAGE_START_INDEX 1

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation JLNimbusTableModel

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithDelegate:(id<NITableViewModelDelegate>)delegate
{
	self = [super initWithDelegate:delegate];
	if (self)
	{
		self.pageCounter = PAGE_START_INDEX;
        self.perpageCount = PERPAGE_COUNT;
		self.hasMoreData = YES;
        
        if (delegate && [delegate isKindOfClass:[NICellFactory class]]) {
            NICellFactory* factory = (NICellFactory*)delegate;
            NIDASSERT([self objectClass]);
            NIDASSERT([self cellClass]);
            [factory mapObjectClass:[self objectClass]
                        toCellClass:[self cellClass]];
        }
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Override

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)relativePath
{
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)listKey
{
	return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSArray*)getListDataFromRootDictionary:(NSDictionary*)dic
{
    id object = [dic objectForKey:[self listKey]];
    if ([object isKindOfClass:[NSArray class]]) {
        return object;
    }
	return [NSArray array];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public

///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)objectClass
{
	return NULL;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)cellClass
{
    return NULL;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSDictionary*)generateParameters
{
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)apiSharedClient
{
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadDataWithBlock:(void(^)(NSArray* indexPaths, NSError *error))block
                     more:(BOOL)more refresh:(BOOL)refresh
{
    if (self.isLoading) {
        return;
    }
    else {
        self.isLoading = YES;
    }
    
    if (more) {
        self.pageCounter++;
    }
    else {
        self.pageCounter = PAGE_START_INDEX;
    }
    
    NSString* relativePath = [self relativePath];
    if (relativePath && [[self apiSharedClient] respondsToSelector:@selector(GET:parameters:refresh:success:failure:)]) {
        [[self apiSharedClient] GET:relativePath parameters:[self generateParameters]  refresh:refresh
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                    self.isLoading = NO;
                                    if (!more) {
                                        if (self.sections.count > 0) {
                                            [self removeSectionAtIndex:0];
                                        }
                                    }
                                    NSArray* entities = [self entitiesParsedFromResponseObject:responseObject];
                                    NSArray* indexPaths = nil;
                                    if (entities.count) {
                                        indexPaths = [self addObjectsFromArray:entities];
                                    }
                                    else {
                                        // just set empty array if no data
                                        indexPaths = [NSArray array];
                                    }
                                    if (block) {
                                        block(indexPaths, nil);
                                    }
                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    self.isLoading = NO;
                                    if (block) {
                                        block(nil, error);
                                    }
                                }];
    }
    else {
        NSLog(@"Error: relativePath is nil OR not find method (GET:parameters:refresh:success:failure:)");
        NSError *error = [[NSError alloc] init];
        self.isLoading = NO;
        if (block) {
            block(nil, error);
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)cancelRequstOperation
{
    if (self.isLoading) {
        [[self apiSharedClient] cancelAllHTTPOperationsWithPath:[self relativePath]];
        self.isLoading = NO;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSArray*)entitiesParsedFromListData:(NSArray*)listDataArray
{
	if (listDataArray.count > 0) {
        NSMutableArray* entities = [NSMutableArray arrayWithCapacity:listDataArray.count];
        if ([[self objectClass] respondsToSelector:@selector(entityWithDictionary:)]) {
            for (NSDictionary* dic in listDataArray) {
                id entity = [[self objectClass] entityWithDictionary:dic];
                [entities addObject:entity];
            }
            return entities;
        }
	}
	return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSArray*)entitiesParsedFromResponseObject:(id)responseObject
{
    NSArray* entities = nil;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary* rootDictionary = (NSDictionary*)responseObject;
        NSArray* listDataArray = [self getListDataFromRootDictionary:rootDictionary];
        entities = [self entitiesParsedFromListData:listDataArray];
        self.hasMoreData = (entities.count >= self.perpageCount) ? YES : NO;
    }
    else if ([responseObject isKindOfClass:[NSArray class]]) {
        entities = [self entitiesParsedFromListData:responseObject];
        self.hasMoreData = (entities.count >= self.perpageCount) ? YES : NO;
    }
    else {
        self.hasMoreData = NO;
    }
    
    return entities;
}

@end
