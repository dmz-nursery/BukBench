//
//  BBISBNdbClient.h
//  BukBench
//
//  Created by Dmitry on 12/25/12.
//  Copyright (c) 2012 Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBISBNdbClient : NSObject 
- (NSURL *)formQueryUrlForTitle:(NSString *)title;
- (NSArray*)extractISBNsFromData:(NSData *)data;
@end
