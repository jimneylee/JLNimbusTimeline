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
#import "JLAFHTTPClient.h"

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
		self.hasMoreEntity = YES;
        
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
- (NSArray*)getListData:(NSDictionary*)dic
{
	return [dic objectForKey:[self listKey]];
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
    if (more) {
        self.pageCounter++;
    }
    else {
        self.pageCounter = PAGE_START_INDEX;
    }
    NSString* relativePath = [self relativePath];
    if ([[self apiSharedClient] respondsToSelector:@selector(getPath:parameters:refresh:success:failure:)]) {
        [[self apiSharedClient] getPath:relativePath parameters:[self generateParameters]  refresh:refresh
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                    if (!more) {
                                        if (self.sections.count > 0) {
                                            [self removeSectionAtIndex:0];
                                        }
                                    }
                                    NSArray* objects = [self parseResponseObject:responseObject];
                                    NSArray* indexPaths = nil;
                                    if (objects.count) {
                                        indexPaths = [self addObjectsFromArray:objects];
                                    }
                                    else {
                                        // just set empty array, show empty data but no error
                                        indexPaths = [NSArray array];
                                    }
                                    if (block) {
                                        block(indexPaths, nil);
                                    }
                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    if (block) {
                                        block(nil, error);
                                    }
                                }];

    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSArray*)entitiesParsedFromListData:(NSArray*)listDataArray
{
	if (listDataArray.count > 0) {
        NSMutableArray* objects = [NSMutableArray arrayWithCapacity:listDataArray.count];
        if ([[self objectClass] respondsToSelector:@selector(entityWithDictionary:)]) {
            for (NSDictionary* dic in listDataArray) {
                id entity = [[self objectClass] entityWithDictionary:dic];
                [objects addObject:entity];
            }
            return objects;
        }
	}
	return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSArray*)parseResponseObject:(id)responseObject
{
    NSArray* objects = nil;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary* rootDictionary = (NSDictionary*)responseObject;
        NSArray* listDataArray = [self getListData:rootDictionary];
        objects = [self entitiesParsedFromListData:listDataArray];
        self.hasMoreEntity = (objects.count >= self.perpageCount) ? YES : NO;
    }
    else if ([responseObject isKindOfClass:[NSArray class]]) {
        objects = [self entitiesParsedFromListData:responseObject];
        self.hasMoreEntity = (objects.count >= self.perpageCount) ? YES : NO;
    }
    else {
        self.hasMoreEntity = NO;
    }
    
    return objects;
}

@end
