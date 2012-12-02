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
        self.title = [aDecoder decodeObjectForKey:@"title"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.title forKey:@"title"];
}

@end
