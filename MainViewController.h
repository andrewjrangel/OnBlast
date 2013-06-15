//
//  MainViewController.h
//  OnBlast
//
//  Created by Ventura Rangel on 6/15/13.
//  Copyright (c) 2013 Antifragile Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIImageView *onBlastLogo;
@property (strong, nonatomic) NSURLRequest *request;
@property (strong, nonatomic) NSDictionary *results;
@property (strong, nonatomic) NSString *searchString;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSArray *resultsArray;

@property (strong, nonatomic) NSString *teamID;
@property (strong, nonatomic) NSString *espnNewsString;
@property (strong, nonatomic) NSString *espnNotesString;
@property (strong, nonatomic) NSString *espnTeamsString;

@property (strong, nonatomic) NSArray *espnNewsArray;
@property (strong, nonatomic) NSArray *espnNotesArray;
@property (strong, nonatomic) NSArray *espnTeamsArray;


- (IBAction)searchButtonPressed:(id)sender;

@end
