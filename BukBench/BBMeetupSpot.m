//
//  BBMeetupSpot.m
//  BukBench
//
//  Created by Dmitry on 1/4/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import "BBMeetupSpot.h"

@interface BBMeetupSpot ()
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subtitle;
@property CLLocationCoordinate2D coordinate;
@end

@implementation BBMeetupSpot
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize coordinate;

+ (BBMeetupSpot *)meetupSpotWithTitle:(NSString *)title
                             subtitle:(NSString *)subtitle
                         atCoordinate:(CLLocationCoordinate2D)coordinate
{
    BBMeetupSpot *spot = [[BBMeetupSpot alloc]init];
    spot.title = title;
    spot.subtitle = subtitle;
    spot.coordinate = coordinate;
    return spot;
}

- (BOOL)isEqual:(id)other
{
    if(self == other)
        return YES;
    if(!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self.title isEqualToString:[(BBMeetupSpot *)other title]] &&
                [self.subtitle isEqualToString: [(BBMeetupSpot *)other subtitle]];
}

- (NSUInteger)hash
{
    int prime = 31;
    int result = 1;
    result = prime * result + [self.title hash];
    result = prime * result + [self.subtitle hash];
    return result;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@", self.title, self.subtitle];
}
@end
