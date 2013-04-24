//
//  BBBook.h
//  BukBench
//
//  Created by Dmitry on 1/5/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBBook : NSObject

+ (BBBook *)bookWithIdentifier:(NSString *)identifier;
- (void)loan;
- (void)returnn;
- (BOOL)isOnLoan;

@end
