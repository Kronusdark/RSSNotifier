//
//  NRSSFeedListItem.m
//  RSSNotifier
//
//  Created by Weston (Home) on 12/1/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import "NRSSFeedListItem.h"

@implementation NRSSFeedListItem

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.lastChecked = [aDecoder decodeObjectForKey:@"lastChecked"];
        self.savedURL = [aDecoder decodeObjectForKey:@"savedURL"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.latestUID = [aDecoder decodeObjectForKey:@"latestUID"];
        self.cachedFeed = [aDecoder decodeObjectForKey:@"cachedFeed"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.lastChecked forKey:@"lastChecked"];
    [aCoder encodeObject:self.savedURL forKey:@"savedURL"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.latestUID forKey:@"latestUID"];
    [aCoder encodeObject:self.cachedFeed forKey:@"cachedFeed"];
}

@end
