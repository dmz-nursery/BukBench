//
//  BBOpenLibraryClient.h
//  BukBench
//
//  Created by Dmitry on 12/26/12.
//  Copyright (c) 2012 Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>
#define OPENLIBRARY_BASE_URS @"http://openlibrary.org/api/books"
#define OPENLIBRARY_BOOK_AUTHOR @"authors._name"
#define OPENLIBRARY_BOOK_TITLE @"title"

@interface BBOpenLibraryClient : NSObject
+ (NSURL *)formQueryURLForISBN:(NSString *)isbn;
@end
