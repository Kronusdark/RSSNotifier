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

- (void)update {
    [self parseInQueue];
}

- (void)parseInQueue {
    for (NRSSFeedListItem *f in [NDataStorage getFeedList]) {
        RSSParser *parser = [[RSSParser alloc] initWithUrl:f.url];
        [parser setDelegate:self];
    }
}

- (void)rssParser:(RSSParser *)parser parsedFeed:(RSSFeed *)feed {
    NSMutableArray *newArticles = [[NSMutableArray alloc] init];
    NSMutableArray *oldFeedList = [[NDataStorage getFeedList] mutableCopy];
    bool foundOldItem = NO;

    for (NRSSFeedListItem *item in oldFeedList) {
        if ([parser.url isEqualToString:item.url]) {
            while (!foundOldItem) {
                for (RSSEntry *article in feed.articles) {
                    if (!item.lastChecked) {
                        item.lastChecked = [[feed.articles lastObject] valueForKey:@"date"];
                    }
                    if ([article.date isEqualToString:item.lastChecked]) {
                        foundOldItem = YES;
                        break;
                    } else if (![article.date isEqualToString:item.lastChecked]) {
                        [article setFeedTitle: item.title];
                        [newArticles addObject:article];
                    }
                }
                item.lastChecked = [[feed.articles objectAtIndex:0] valueForKey:@"date"];
            }
        }
    }
    
    if (newArticles.count > 0) {
        [_delegate newFeedItems:newArticles];
    }


    [NDataStorage setFeedList:oldFeedList];


}
@end
