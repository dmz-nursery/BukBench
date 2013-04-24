//
//  BBBook.m
//  BukBench
//
//  Created by Dmitry on 1/5/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import "BBBook.h"

@interface BBBook ()
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) NSDate *created;
@property BOOL onLoan;
@property int timesBorrowed;
@end

@implementation BBBook
@synthesize identifier = _identifier;
@synthesize created = _created;

+ (BBBook *)bookWithIdentifier:(NSString *)identifier
{
    BBBook *book = [[BBBook alloc] initWithIdentifier:identifier];
    book.created = [NSDate date];
    book.onLoan = NO;
    book.timesBorrowed = 0;
    return book;
}

- (id)initWithIdentifier:(NSString *)identifier
{
    self = [super init];
    if(self) {
        _identifier = identifier;
    }
    return self;
}
    
- (void)loan
{
    self.onLoan = YES;
    self.timesBorrowed ++;
    
}

- (void)returnn
{
    self.onLoan = NO;
}

- (BOOL)isOnLoan
{
    return self.onLoan;
}
    
@end
