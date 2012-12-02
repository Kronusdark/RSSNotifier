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
@property (strong, nonatomic) NSString *title;

@end
