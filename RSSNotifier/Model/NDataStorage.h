//
//  NDataStorage.h
//  RSSNotifier
//
//  Created by Weston (Work) on 11/30/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDataStorage : NSObject

@property (weak) NSArray *feeds;
@property (weak) NSDictionary *settings;


@end
