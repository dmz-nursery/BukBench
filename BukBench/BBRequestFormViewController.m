//
//  BBRequestFormViewController.m
//  BukBench
//
//  Created by Dmitry on 1/7/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import "BBRequestFormViewController.h"
#import "OpenLibBook.h"
#import "BBMeetupSpotDropDownMenu.h"
#import "UIDropDownMenu.h"

@interface BBRequestFormViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthor;
@property (weak, nonatomic) IBOutlet UILabel *lblIsbn;
@property (weak, nonatomic) IBOutlet UITextField *txtLoanDuration;
@property (weak, nonatomic) IBOutlet UITextField *txtPreferredMeetupSpot;
@property (nonatomic, strong) BBMeetupSpotDropDownMenu *meetupMenu;
@property (nonatomic, strong) UIDropDownMenu *loanDurationMenu;
@property (weak, nonatomic) UITextView *txtNoteToOwner;

@end

@implementation BBRequestFormViewController
@synthesize requestedBook = _requestedBook;
@synthesize bookOwner = _bookOwner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //IB does not render control placements correctly in the lower half of the screen
    //add a "note to owner" textView
    CGRect textViewFrame = CGRectMake(20, 240, 280, 70);
    UITextView *textView = [[UITextView alloc] initWithFrame:textViewFrame];
    textView.delegate = self;
    [self.view addSubview:textView];
    self.txtNoteToOwner = textView;
    self.txtNoteToOwner.font = [UIFont fontWithName:@"Noteworthy" size:15.0];
    
    //add a "submit" button
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submitButton addTarget:self
               action:@selector(submitPressed:)
     forControlEvents:UIControlEventTouchDown];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(100, 325, 120, 30);
    [self.view addSubview:submitButton];

    self.lblTitle.text = [OpenLibBook titleForBook:self.requestedBook];
    self.lblAuthor.text = [OpenLibBook authorForBook:self.requestedBook];
    self.lblIsbn.text = [OpenLibBook isbn13ForBook:self.requestedBook];
    if(!self.lblIsbn.text) [OpenLibBook isbn10ForBook:self.requestedBook];
    self.txtNoteToOwner.text = [NSString stringWithFormat:@"%@ %@", @"Note to", self.bookOwner.firstName];
    
    self.meetupMenu = [[BBMeetupSpotDropDownMenu alloc] init];
    NSSet *meetupSpots = [self.bookOwner canMeetAtSpots:[BBUser sharedUser].meetupSpots];
    if(!meetupSpots) meetupSpots = self.bookOwner.meetupSpots;
    NSMutableArray *descriptions = [NSMutableArray arrayWithCapacity:[meetupSpots count]];
    for(BBMeetupSpot *spot in meetupSpots) {
        [descriptions addObject:[spot description]];
    }
    
    [self.meetupMenu makeMenu:self.txtPreferredMeetupSpot
             titleArray:descriptions
             valueArray:descriptions
             targetView:self.view];
    
    self.loanDurationMenu = [[UIDropDownMenu alloc] init];
    NSArray *durations= [NSArray arrayWithObjects:@"Couple of days",
                                                  @"1 week",
                                                  @"2 weeks",
                                                  @"A month", nil];
    
    [self.loanDurationMenu makeMenu:self.txtLoanDuration
                   titleArray:durations
                   valueArray:durations
                   targetView:self.view];
    
    self.navigationItem.title = @"Request";
}

- (void)submitPressed:(id)sender
{
    [self performSegueWithIdentifier:@"Request submitted" sender:self];
}

- (IBAction)userSelectedPreferredMeetupSpotTextField:(id)sender {
    [self textControlDidBeginEditing:sender];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self textControlDidBeginEditing:textView];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self textControlDidEndEditing:textView];
}

- (void)textControlDidBeginEditing:(id)textControl {
    [self animateTextControl:(id)textControl up:YES];
}

- (void)textControlDidEndEditing:(id)textControl {
    [self animateTextControl:(id)textControl up:NO];
}

#define VIEW_MOVEMENT_DISTANCE 160
#define VIEW_MOVEMENT_DURATION 0.3f

- (void)animateTextControl:(id)textControl up:(BOOL)up
{
    int movement = (up ? -VIEW_MOVEMENT_DISTANCE : VIEW_MOVEMENT_DISTANCE);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: VIEW_MOVEMENT_DURATION];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
