//
//  BBISBNdbClient.m
//  BukBench
//
//  Created by Dmitry on 12/25/12.
//  Copyright (c) 2012 Dmitry. All rights reserved.
//

#import "BBISBNdbClient.h"
#define ISBNDB_BASE_URL @"http://isbndb.com/api/books.xml" //for the "books" collection
#define ISBNDB_ACCESS_KEY @"LOJ49AUS"

@interface BBISBNdbClient() <NSXMLParserDelegate>
@property (nonatomic,strong) NSMutableArray *isbnList;
@end

@implementation BBISBNdbClient
@synthesize isbnList = _isbnList;


- (NSURL *)formQueryUrlForTitle:(NSString *)title
{
    NSString *query = [ISBNDB_BASE_URL stringByAppendingString:[@"?access_key="
                                       stringByAppendingString:[ISBNDB_ACCESS_KEY
                                       stringByAppendingString:@"&index1=title&value1="]]];
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    title = [title stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    query = [query stringByAppendingString:title];
    return [NSURL URLWithString:query];
}

- (NSArray*)extractISBNsFromData:(NSData *)data
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    BOOL success = [parser parse];        // 2Bfixed: parse in a background queueu
    return success ? self.isbnList : nil;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if(!_isbnList) _isbnList = [NSMutableArray array];
    if([elementName isEqualToString:@"BookData"]) {
        NSString *isbn = [attributeDict objectForKey:@"isbn"];
        [self.isbnList addObject:isbn];
    }
}

@end
