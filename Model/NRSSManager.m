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
        MWFeedParser *parser = [[MWFeedParser alloc] initWithFeedURL:f.url];
        [parser setConnectionType:ConnectionTypeAsynchronously];
        [parser setDelegate:self];
        [parser parse];
    }
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    NSMutableArray *oldFeedList = [[NDataStorage getFeedList] mutableCopy];
    for (NRSSFeedListItem *feedListItem in oldFeedList) {
        if ([parser.url isEqualTo:feedListItem.url]) {
            if (![feedListItem lastChecked]) {
                feedListItem.lastChecked = [NSDate date];
            }
            if ([item.date isGreaterThan:[feedListItem lastChecked]]) {
                [_delegate newFeedItems:item title:feedListItem.title];
                feedListItem.lastChecked = [NSDate date];
            }
        }
    }
    [NDataStorage setFeedList:oldFeedList];
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}
@end
