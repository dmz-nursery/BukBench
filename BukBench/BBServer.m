//
//  BBServer.m
//  BukBench
//
//  Created by Dmitry on 1/5/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import "BBServer.h"
#import "BBUser.h"

@interface BBServer ()
@property (nonatomic,strong) NSMutableArray *userDB;
@property (nonatomic,strong) NSMutableDictionary *meetupSpotDB;
@end

@implementation BBServer
@synthesize userDB = _userDB;
@synthesize meetupSpotDB = _meetupSpotDB;


//OpenLib test book IDs
#define THE_BELL_JAR @"OL9233609M"
#define THE_GREAT_GATSBY @"OL9874517Mf"
#define THE_READER @"OL24334329M"
#define THE_IDIOT @"OL7820477M"
#define GIRL_INTERRUPTED @"OL1489337M"
#define ANGELS_IN_AMERICA @"OL1393120M"
#define WOMAN_WARRIOR @"OL9258308M"


//meetupSpotDB keys
#define UNION_SQ_PK_STATUE @"UnionSqPk_Statue"
#define BATTERY_PK_CLINTON @"BatteryPk_Clinton"
#define WASH_SQ_PK_ARCH @"WashingtonSqPk_Arch"
#define COLUMBUS_CRCL @"ColumbusCircle_Gallery"
#define BRYANT_PK_LIB @"BryantPk_Library"
#define CENTRAL_PK_IMAGINE @"CentralPk_Imagine"
#define CENTRAL_PK_BETHESDA @"CentralPk_Bethesda"
#define CITY_HALL_PK_FOUNTAIN @"CityHallPark_Fountain"


- (NSMutableArray *)userDB
{
    if(!_userDB) {
        _userDB = [NSMutableArray array];
        [self initializeUserDB];
    }
    return _userDB;
}

- (NSMutableDictionary *)meetupSpotDB
{
    if(!_meetupSpotDB) {
        _meetupSpotDB = [NSMutableDictionary dictionary];
        [self initializeMeetUpSpotDB];
    }
    return _meetupSpotDB;
}

- (void)initializeUserDB  
{
    BBUser *userA = [[BBUser alloc] init];
    userA.firstName = @"Neil";
    userA.lastName = @"Halsted";
    [userA addBookToBookshelfByIdentifier:THE_BELL_JAR];
    [userA addBookToBookshelfByIdentifier:THE_GREAT_GATSBY];
    [userA addBookToBookshelfByIdentifier:THE_READER];
    [userA addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:UNION_SQ_PK_STATUE]];
    [userA addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:BATTERY_PK_CLINTON]];
    [userA addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:WASH_SQ_PK_ARCH]];
    [self.userDB addObject:userA];
    
    BBUser *userB = [[BBUser alloc] init];
    userB.firstName = @"Robert";
    userB.lastName = @"Smith";
    [userB addBookToBookshelfByIdentifier:THE_GREAT_GATSBY];
    [userB addBookToBookshelfByIdentifier:THE_READER];
    [userB addBookToBookshelfByIdentifier:THE_IDIOT];
    [userB addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:BATTERY_PK_CLINTON]];
    [userB addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:WASH_SQ_PK_ARCH]];
    [userB addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:COLUMBUS_CRCL]];
    [self.userDB addObject:userB];
    
    BBUser *userC = [[BBUser alloc] init];
    userC.firstName = @"Rachel";
    userC.lastName = @"Goswell";
    [userC addBookToBookshelfByIdentifier:THE_READER];
    [userC addBookToBookshelfByIdentifier:THE_IDIOT];
    [userC addBookToBookshelfByIdentifier:GIRL_INTERRUPTED];
    [userC addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:WASH_SQ_PK_ARCH]];
    [userC addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:COLUMBUS_CRCL]];
    [userC addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:BRYANT_PK_LIB]];
    [self.userDB addObject:userC];
    
    BBUser *userD = [[BBUser alloc] init];
    userD.firstName = @"Kevin";
    userD.lastName = @"Shields";
    [userD addBookToBookshelfByIdentifier:THE_IDIOT];
    [userD addBookToBookshelfByIdentifier:GIRL_INTERRUPTED];
    [userD addBookToBookshelfByIdentifier:ANGELS_IN_AMERICA];
    [userD addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:COLUMBUS_CRCL]];
    [userD addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:BRYANT_PK_LIB]];
    [userD addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:CENTRAL_PK_IMAGINE]];
    [self.userDB addObject:userD];
    
    BBUser *userE = [[BBUser alloc] init];
    userE.firstName = @"Amanda";
    userE.lastName = @"Palmer";
    [userE addBookToBookshelfByIdentifier:GIRL_INTERRUPTED];
    [userE addBookToBookshelfByIdentifier:ANGELS_IN_AMERICA];
    [userE addBookToBookshelfByIdentifier:WOMAN_WARRIOR];
    [userE addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:BRYANT_PK_LIB]];
    [userE addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:CENTRAL_PK_IMAGINE]];
    [userE addSpotToMeetupSpots:[self.meetupSpotDB objectForKey:CITY_HALL_PK_FOUNTAIN]];
    [self.userDB addObject:userE];
    
}

- (void)initializeMeetUpSpotDB
{
    //--------MEETUPSPOTS---------------------
    // Union Square Park (Washington statue): 40.735015, -73.991171
    // Battery Park (Castle Clinton entrance): 40.703558,-74.016531
    // Washington Square Park (The Arch): 40.731257,-73.997126
    // Columbus Circle (Columbus Cirlcle Gallery): 40.767926,-73.982103
    // Bryant Park (New York Public Library entrance): 40.752914,-73.981542
    // Central Park (Strawberry Fields, "Imagine" memorial): 40.77572,-73.975137
    // Central Park (Bethesda Fountain): 40.77572,-73.975137
    // City Hall Park (The Fountain): 40.712144,-74.007181
    //----------------------------------------
    
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude = 40.735015;
    coordinate.longitude = -73.991171;
    BBMeetupSpot *UnionSqPk = [BBMeetupSpot meetupSpotWithTitle:@"Union Square Park"
                                                       subtitle:@"Washington Statue"
                                                   atCoordinate:coordinate];
    [self.meetupSpotDB setObject:UnionSqPk forKey:UNION_SQ_PK_STATUE];
    
    coordinate.latitude = 40.703558;
    coordinate.longitude = -74.016531;
    BBMeetupSpot *BatteryPk = [BBMeetupSpot meetupSpotWithTitle:@"Battery Park"
                                                       subtitle:@"Castle Clinton Entrance"
                                                        atCoordinate:coordinate];
    [self.meetupSpotDB setObject:BatteryPk forKey:BATTERY_PK_CLINTON];
    
    coordinate.latitude = 40.731257;
    coordinate.longitude = -73.997126;
    BBMeetupSpot *WashingtonSqPk = [BBMeetupSpot meetupSpotWithTitle:@"Washington Square Park"
                                                            subtitle:@"Washington Arch"
                                                        atCoordinate:coordinate];
    [self.meetupSpotDB setObject:WashingtonSqPk forKey:WASH_SQ_PK_ARCH];
    
    coordinate.latitude = 40.767926;
    coordinate.longitude = -73.982103;
    BBMeetupSpot *ColumbusCircle = [BBMeetupSpot meetupSpotWithTitle:@"Columbus Circle"
                                                            subtitle:@"Columbus Circle Galery"
                                                        atCoordinate:coordinate];
    [self.meetupSpotDB setObject:ColumbusCircle forKey:COLUMBUS_CRCL];
    
    coordinate.latitude = 40.752914;
    coordinate.longitude = -73.981542;
    BBMeetupSpot *BryantPk = [BBMeetupSpot meetupSpotWithTitle:@"Bryant Park"
                                                      subtitle:@"Public Library Entrance"
                                                  atCoordinate:coordinate];
    [self.meetupSpotDB setObject:BryantPk forKey:BRYANT_PK_LIB];
    
    coordinate.latitude = 40.77572;
    coordinate.longitude = -73.975137;
    BBMeetupSpot *CentralPk_Imagine = [BBMeetupSpot meetupSpotWithTitle:@"Central Park"
                                                              subtitle:@"Imagine Memorial"
                                                          atCoordinate:coordinate];
    [self.meetupSpotDB setObject:CentralPk_Imagine forKey:CENTRAL_PK_IMAGINE];

    coordinate.latitude = 40.77572;
    coordinate.longitude = -73.975137;
    BBMeetupSpot *CentralPk_Bethesda = [BBMeetupSpot meetupSpotWithTitle:@"Central Park"
                                                                subtitle:@"Bethesda Fountain"
                                                            atCoordinate:coordinate];
    [self.meetupSpotDB setObject:CentralPk_Bethesda forKey:CENTRAL_PK_BETHESDA];
    
    coordinate.latitude = 40.712144;
    coordinate.longitude = -74.007181;
    BBMeetupSpot *CityHallPk = [BBMeetupSpot meetupSpotWithTitle:@"City Hall Park"
                                                        subtitle:@"The Fountain"
                                                    atCoordinate:coordinate];
    [self.meetupSpotDB setObject:CityHallPk forKey:CITY_HALL_PK_FOUNTAIN];
}

- (NSArray *)usersWithBook:(NSDictionary *)book
{
    NSMutableArray *usergroup = [NSMutableArray array];
    for(BBUser* user in self.userDB) {
        if([user ownsTheBook:book])
            [usergroup addObject:user];
    }
    return usergroup;
}

- (NSArray *)allMeetupSpots
{
    return [self.meetupSpotDB allValues];
}

@end
