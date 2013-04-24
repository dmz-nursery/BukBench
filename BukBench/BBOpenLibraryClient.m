//
//  BBOpenLibraryClient.m
//  BukBench
//
//  Created by Dmitry on 12/26/12.
//  Copyright (c) 2012 Dmitry. All rights reserved.
//

#import "BBOpenLibraryClient.h"

@implementation BBOpenLibraryClient

+ (NSURL *)formQueryURLForISBN:(NSString *)isbn
{
    NSString *query = [OPENLIBRARY_BASE_URS stringByAppendingString:[@"?bibkeys=ISBN"
                                            stringByAppendingString:[isbn
                                            stringByAppendingString:@"&jscmd=data&format=json"]]];
    return [NSURL URLWithString:query];
}

@end
