//
//  OpenLibBook.h
//  BukBench
//
//  Created by Dmitry on 1/7/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenLibBook : NSObject
+ (NSString *)titleForBook:(NSDictionary *)book;
+ (NSString *)authorForBook:(NSDictionary *)book;
+ (NSString *)publisherForBook:(NSDictionary *)book;
+ (NSString *)publicationDateForBook:(NSDictionary *)book;
+ (NSString *)isbn10ForBook:(NSDictionary *)book;
+ (NSString *)isbn13ForBook:(NSDictionary *)book;
+ (NSString *)openLibIdForBook:(NSDictionary *)book;
+ (NSString *)coverImageForBookSmall:(NSDictionary *)book;
+ (NSString *)coverImageForBookMedium:(NSDictionary *)book;
+ (NSString *)coverImageForBookLarge:(NSDictionary *)book;
@end
