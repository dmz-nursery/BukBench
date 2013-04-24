//
//  BBMeetupSpot.h
//  BukBench
//
//  Created by Dmitry on 1/4/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BBMeetupSpot : NSObject

+ (BBMeetupSpot *)meetupSpotWithTitle:(NSString *)title
                             subtitle:(NSString *)subtitle
                         atCoordinate:(CLLocationCoordinate2D)coordinate;
- (NSString *)title;
- (NSString *)subtitle;
- (NSString *)description;
@end
