//
//  NDataStorage.h
//  RSSNotifier
//
//  Created by Weston (Work) on 11/30/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDataStorage : NSObject

+ (NSArray *)getFeeds;
+ (void)setFeeds:(NSArray *)feeds;

+ (NSDictionary *)getSettings;
+ (void)setSettings:(NSDictionary *)settings;

@end
