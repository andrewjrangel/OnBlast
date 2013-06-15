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

@implementation MainViewController{
    int teamColor;
}

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
    self.searchString = [NSString stringWithFormat:@"http://api.espn.com/v1/sports/basketball/nba/teams/2?_accept=application%@&apikey=%@", jsonEscapeString, espnAPIKey];
    
    
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
        
        
        //NSLog(@"%@", stepThree);
        
        self.teamColor = [[stepThree objectAtIndex:0]objectForKey:@"color"];
        self.teamLocation = [[stepThree objectAtIndex:0]objectForKey:@"location"];
        self.teamName = [[stepThree objectAtIndex:0]objectForKey:@"name"];
        
    
        


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
        
        NSLog(@"%@", self.teamName);
        NSLog(@"%@", self.teamColor);
        NSLog(@"%@", self.teamLocation);
        
        self.teamLocationLabel.text = self.teamLocation;
        self.teamNameLabel.text = self.teamName;
        
        if ([self.teamName isEqualToString:@"Bucks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x003813);
            
        } else if ([self.teamName isEqualToString:@"Heat"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        } else if ([self.teamName isEqualToString:@"Celtics"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x006532);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        }
     

    }];
}



@end
