//
//  OpenLibBook.m
//  BukBench
//
//  Created by Dmitry on 1/7/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import "OpenLibBook.h"

@implementation OpenLibBook

+ (NSString *)titleForBook:(NSDictionary *)book
{
    NSDictionary *bookInfo = [book objectForKey:[[book allKeys] lastObject]];
    return [bookInfo objectForKey:@"title"];
}

+ (NSString *)authorForBook:(NSDictionary *)book
{
    NSDictionary *bookInfo = [book objectForKey:[[book allKeys] lastObject]];
    return [[[bookInfo objectForKey:@"authors"] lastObject] objectForKey:@"name"];
}

+ (NSString *)publisherForBook:(NSDictionary *)book
{
    NSDictionary *bookInfo = [book objectForKey:[[book allKeys] lastObject]];
    return [[[bookInfo objectForKey:@"publishers"] lastObject] objectForKey:@"name"];
}

+ (NSString *)publicationDateForBook:(NSDictionary *)book
{
    NSDictionary *bookInfo = [book objectForKey:[[book allKeys] lastObject]];
    return [bookInfo objectForKey:@"publish_date"];
}

+ (NSString *)isbn10ForBook:(NSDictionary *)book
{
    NSDictionary *bookInfo = [book objectForKey:[[book allKeys] lastObject]];
    return [[[bookInfo objectForKey:@"identifiers"] valueForKey:@"isbn_10"] lastObject];
}

+ (NSString *)isbn13ForBook:(NSDictionary *)book
{
    NSDictionary *bookInfo = [book objectForKey:[[book allKeys] lastObject]];
    return [[[bookInfo objectForKey:@"identifiers"] valueForKey:@"isbn_13"] lastObject];
}

+ (NSString *)openLibIdForBook:(NSDictionary *)book
{
    NSDictionary *bookInfo = [book objectForKey:[[book allKeys] lastObject]];
    return [[[bookInfo objectForKey:@"identifiers"] valueForKey:@"openlibrary"] lastObject];
}

+ (NSString *)coverImageForBookSmall:(NSDictionary *)book
{
    NSDictionary *bookInfo = [book objectForKey:[[book allKeys] lastObject]];
    return [[bookInfo valueForKey:@"cover"] valueForKey:@"small"];
}

+ (NSString *)coverImageForBookMedium:(NSDictionary *)book
{
    NSDictionary *bookInfo = [book objectForKey:[[book allKeys] lastObject]];
    return [[bookInfo valueForKey:@"cover"] valueForKey:@"medium"];
}

+ (NSString *)coverImageForBookLarge:(NSDictionary *)book
{
    NSDictionary *bookInfo = [book objectForKey:[[book allKeys] lastObject]];
    return [[bookInfo valueForKey:@"cover"] valueForKey:@"large"];
}
@end
