//
//  NRSSManager.m
//  RSSNotifier
//
//  Created by Weston (Work) on 11/30/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import "NRSSManager.h"
#import "NDataStorage.h"
#import "NRSSFeedListItem.h"

@implementation NRSSManager


- (void)parseInQueue {
    for (NRSSFeedListItem *f in [NDataStorage getFeedList]) {
        RSSParser *parser = [[RSSParser alloc] initWithUrl:f.title];
        [parser setDelegate:self];
        [parser parse];
    }
}

- (void)rssParser:(RSSParser *)parser parsedFeed:(RSSFeed *)feed {
    NSMutableArray *oldArray = [[NDataStorage getFeeds] mutableCopy];
    for (RSSFeed *f in oldArray) {
        
        // Update cache
        if ([f.url isEqualToString:feed.url]) {
            if (![[f.articles objectAtIndex:0] isEqualToString:[feed.articles objectAtIndex:0]]) {
                [self.delegate newFeedItem:feed];
            }
            [oldArray removeObject:f];
            [oldArray addObject:feed];
        } else {
            [self.delegate newFeedItem:feed];
        }

    }
}
@end
