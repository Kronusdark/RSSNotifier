//
//  NRSSFeedListItem.h
//  RSSNotifier
//
//  Created by Weston (Home) on 12/1/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRSSFeedListItem : NSObject <NSCoding>

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *lastChecked;
@property (strong, nonatomic) NSString *savedURL;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *latestUID;
@property (strong, nonatomic) RSSFeed *cachedFeed;
@end
