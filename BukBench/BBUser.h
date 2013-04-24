//
//  BBUser.h
//  BukBench
//
//  Created by Dmitry on 1/3/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBMeetupSpot.h"

@interface BBUser : NSObject

+ (BBUser *)sharedUser; //application user

- (NSString *)firstName;
- (NSString *)lastName;
- (NSDictionary *)bookshelf;
- (NSSet *)readList;
- (NSSet *)meetupSpots;
- (void)setFirstName:(NSString *)firstName;
- (void)setLastName:(NSString *)lastName;

- (void)addBookToBookshelf:(NSDictionary *)book;        //openlibrary book dictionary
- (void)addBookToBookshelfByIdentifier:(NSString *)identifier; //openlibrary book id
- (void)addBookToReadList:(NSDictionary *)book;         //openlibrary book dictionary
- (void)addSpotToMeetupSpots:(BBMeetupSpot *)meetupSpot;
- (BOOL)ownsTheBook:(NSDictionary *)book;               //openlibrary book dictionary
- (NSSet *)canMeetAtSpots:(NSSet *)meetupSpots;
@end
