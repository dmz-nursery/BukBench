//
//  BBUser.m
//  BukBench
//
//  Created by Dmitry on 1/3/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import "BBUser.h"
#import "BBBook.h"
#import "OpenLibBook.h"

@interface BBUser ()
@property (nonatomic,strong) NSString *firstName;
@property (nonatomic,strong) NSString *lastName;
@property (nonatomic,strong) NSMutableDictionary *bookshelf;
@property (nonatomic,strong) NSMutableSet *readList;
@property (nonatomic,strong) NSMutableSet *meetupSpots;
@end

@implementation BBUser
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize bookshelf = _bookshelf;
@synthesize readList = _readList;
@synthesize meetupSpots = _meetupSpots;
static BBUser *sharedUser = nil;

//singleton setup
+ (BBUser *)sharedUser
{
    @synchronized(self) {
        if(!sharedUser) {
            sharedUser = [[BBUser alloc] init];
        }
    }
    return sharedUser;
}

- (id)init
{
    self = [super init];
    return self;
}

- (NSMutableDictionary *)myBookshelf
{
    if(_bookshelf == nil)
        _bookshelf = [NSMutableDictionary dictionary];
    return _bookshelf;
}

- (NSMutableSet *)myReadList
{
    if(_readList == nil)
        _readList = [NSMutableSet set];
    return _readList;
}

- (NSMutableSet *)myMeetupSpots
{
    if(_meetupSpots == nil)
        _meetupSpots = [NSMutableSet set];
    return _meetupSpots;
}

- (NSSet *)bookshelf
{
    return [self.myBookshelf copy];
}

- (NSSet *)readList
{
    return [self.myReadList copy];
}

- (NSSet *)meetupSpots
{
    return [self.myMeetupSpots copy];
}

- (void)addBookToBookshelf:(NSDictionary *)book
{
    NSString *identifier = [OpenLibBook openLibIdForBook:book]; //needs testing
    BBBook *bukBenchBook = [BBBook bookWithIdentifier:identifier];
    [self.myBookshelf setObject:bukBenchBook forKey:identifier];
}

- (void)addBookToBookshelfByIdentifier:(NSString *)identifier
{
    BBBook *bukBenchBook = [BBBook bookWithIdentifier:identifier];
    [self.myBookshelf setObject:bukBenchBook forKey:identifier];
}

- (void)addBookToReadList:(NSDictionary *)book
{
    [self.myReadList addObject:[OpenLibBook openLibIdForBook:book]]; //needs testing
}

- (void)addSpotToMeetupSpots:(BBMeetupSpot *)meetupSpot
{
    [self.myMeetupSpots addObject:meetupSpot];
}
//move to bookshelf
- (BOOL)ownsTheBook:(NSDictionary *)book
{
    NSSet *bookSet = [NSSet setWithObject:[OpenLibBook openLibIdForBook:book]];
    NSSet *bookshelfSet = [NSSet setWithArray:[self.myBookshelf allKeys]];
    return [bookSet isSubsetOfSet:bookshelfSet];
}
//move to meetupspots
- (NSSet *)canMeetAtSpots:(NSSet *)meetupSpots
{
    NSMutableSet *meetupSpotsCopy = [meetupSpots mutableCopy];
    [meetupSpotsCopy intersectSet:[self myMeetupSpots]];
    return [meetupSpotsCopy count]? meetupSpotsCopy : nil;
}

@end
