//
//  MainViewController.m
//  OnBlast
//
//  Created by Ventura Rangel on 6/15/13.
//  Copyright (c) 2013 Antifragile Development. All rights reserved.
//

#import "MainViewController.h"
#import "AFNetworking.h"
#define espnAPIKey @"d2b4nv43v29nvzthmdntra2x"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self test];
    
    
    
}

- (IBAction)searchButtonPressed:(id)sender{
    NSString *encodedString = [self.searchTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *jsonEscapeString = @"%2Fjson";
    self.searchString = [NSString stringWithFormat:@"http://api.espn.com/v1/sports/basketball/nba/teams/14?_accept=application%@&apikey=%@", jsonEscapeString, espnAPIKey];
    
    
    self.url = [NSURL URLWithString:self.searchString];
    self.request = [NSURLRequest requestWithURL:self.url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:self.request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.results = JSON;
        //NSLog(@"%@", self.results);
        self.resultsArray = [self.results objectForKey:@"sports"];
        NSDictionary *stepOne = [self.resultsArray objectAtIndex:0];
        NSArray *stepTwo = [stepOne objectForKey:@"leagues"];
        NSArray *stepThree = [[stepTwo objectAtIndex:0]objectForKey:@"teams"];
        self.teamID = [[stepThree objectAtIndex:0]objectForKey:@"id"];
        NSArray *stepFour = [[[stepThree objectAtIndex:0] objectForKey:@"links"]objectForKey:@"api"];
        self.espnNewsArray = [[[[[stepThree objectAtIndex:0] objectForKey:@"links"]objectForKey:@"api"] objectForKey:@"news"] objectForKey:@"href"];
        self.espnNotesArray = [[[[[stepThree objectAtIndex:0] objectForKey:@"links"]objectForKey:@"api"] objectForKey:@"notes"] objectForKey:@"href"];
        self.espnTeamsArray = [[[[[stepThree objectAtIndex:0] objectForKey:@"links"]objectForKey:@"api"] objectForKey:@"teams"] objectForKey:@"href"];
        
        self.espnNewsString = [NSString stringWithFormat:@"%@", self.espnNewsArray];
        self.espnNotesString = [NSString stringWithFormat:@"%@", self.self.espnNotesArray];
        self.espnTeamsString = [NSString stringWithFormat:@"%@", self.espnTeamsArray];
        
        
        NSLog(@"%@", stepThree);
        
        
        

        [[NSNotificationCenter defaultCenter]postNotificationName:@"JSONfinished" object:nil];
        

        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //
    }];
    [operation start];
   
    
    
    
}

-(void)test{
    NSNotificationCenter *jsonNotification = [NSNotificationCenter defaultCenter];
    [jsonNotification addObserverForName:@"JSONfinished" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
//        NSLog(@"%@", self.espnNewsString);
//        NSLog(@"%@", self.espnNotesString);
//        NSLog(@"%@", self.espnTeamsString);
        
        NSString *appendingString = [NSString stringWithFormat:@"?apikey=%@", espnAPIKey];
        
        NSURL *url = [NSURL URLWithString:[self.espnTeamsString stringByAppendingString:appendingString]];
        //NSLog(@"%@", url);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
           // NSLog(@"%@", JSON);
            
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"Error in void test");
        }];
        
        [operation start];

    }];
}



@end
