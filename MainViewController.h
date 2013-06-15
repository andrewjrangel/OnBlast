//
//  MainViewController.h
//  OnBlast
//
//  Created by Ventura Rangel on 6/15/13.
//  Copyright (c) 2013 Antifragile Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIImageView *onBlastLogo;

@property (strong, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *teamLocationLabel;
@property (strong, nonatomic) IBOutlet UILabel *teamAbbreviationLabel;
@property (strong, nonatomic) IBOutlet UILabel *leagueLabel;
@property (strong, nonatomic) IBOutlet UILabel *linksLabel;

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

@property (strong, nonatomic) NSString *teamColor;
@property (strong, nonatomic) NSString *teamAbbreviation;
@property (strong, nonatomic) NSString *teamLocation;
@property (strong, nonatomic) NSString *teamName;








- (IBAction)searchButtonPressed:(id)sender;

@end
