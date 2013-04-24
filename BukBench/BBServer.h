//
//  BBServer.h
//  BukBench
//
//  Created by Dmitry on 1/5/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBServer : NSObject

- (NSArray *)usersWithBook:(NSDictionary *)book;  //openlibrary book dictionary
- (NSArray *)allMeetupSpots;

@end
