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
    [self.searchTextField resignFirstResponder];
    
    NSString *encodedString = [self.searchTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([encodedString isEqualToString:@"Hawks"]) {
        self.teamID = @"1";
    } else if ([encodedString isEqualToString:@"Celtics"]) {
        self.teamID = @"2";
    } else if ([encodedString isEqualToString:@"Pelicans"]) {
       self.teamID = @"3";
    } else if ([encodedString isEqualToString:@"Bulls"]) {
        self.teamID = @"4";
    } else if ([encodedString isEqualToString:@"Cavaliers"]) {
        self.teamID = @"5";
    } else if ([encodedString isEqualToString:@"Mavericks"]) {
        self.teamID = @"6";
    } else if ([encodedString isEqualToString:@"Nuggets"]) {
        self.teamID = @"7";
    } else if ([encodedString isEqualToString:@"Pistons"]) {
        self.teamID = @"8";
    } else if ([encodedString isEqualToString:@"Warriors"]) {
        self.teamID = @"9";
    } else if ([encodedString isEqualToString:@"Rockets"]) {
        self.teamID = @"10";
    } else if ([encodedString isEqualToString:@"Pacers"]) {
        self.teamID = @"11";
    } else if ([encodedString isEqualToString:@"Clippers"]) {
        self.teamID = @"12";
    } else if ([encodedString isEqualToString:@"Lakers"]) {
        self.teamID = @"13";
    } else if ([encodedString isEqualToString:@"Heat"]) {
        self.teamID = @"14";
    } else if ([encodedString isEqualToString:@"Bucks"]) {
        self.teamID = @"15";
    } else if ([encodedString isEqualToString:@"Timberwolves"]) {
        self.teamID = @"16";
    } else if ([encodedString isEqualToString:@"Nets"]) {
        self.teamID = @"17";
    } else if ([encodedString isEqualToString:@"Knicks"]) {
        self.teamID = @"18";
    } else if ([encodedString isEqualToString:@"Magic"]) {
        self.teamID = @"19";
    } else if ([encodedString isEqualToString:@"76ers"]) {
        self.teamID = @"20";
    } else if ([encodedString isEqualToString:@"Suns"]) {
        self.teamID = @"21";
    } else if ([encodedString isEqualToString:@"Trail Blazers"]) {
        self.teamID = @"22";
    } else if ([encodedString isEqualToString:@"Kings"]) {
        self.teamID = @"23";
    } else if ([encodedString isEqualToString:@"Spurs"]) {
        self.teamID = @"24";
    } else if ([encodedString isEqualToString:@"Thunder"]) {
        self.teamID = @"25";
    }else if ([encodedString isEqualToString:@"Jazz"]) {
        self.teamID = @"26";
    }else if ([encodedString isEqualToString:@"Wizards"]) {
        self.teamID = @"27";
    }else if ([encodedString isEqualToString:@"Raptors"]) {
        self.teamID = @"28";
    }else if ([encodedString isEqualToString:@"Grizzlies"]) {
        self.teamID = @"29";
    }else if ([encodedString isEqualToString:@"Bobcats"]) {
        self.teamID = @"30";
    }
        
    
    
    NSString *jsonEscapeString = @"%2Fjson";
    self.searchString = [NSString stringWithFormat:@"http://api.espn.com/v1/sports/basketball/nba/teams/%@?_accept=application%@&apikey=%@",self.teamID, jsonEscapeString, espnAPIKey];
    
    self.url = [NSURL URLWithString:self.searchString];
    self.request = [NSURLRequest requestWithURL:self.url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:self.request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.results = JSON;
        //NSLog(@"%@", self.results);
        self.resultsArray = [self.results objectForKey:@"sports"];
        NSDictionary *stepOne = [self.resultsArray objectAtIndex:0];
        NSArray *stepTwo = [stepOne objectForKey:@"leagues"];
        NSArray *stepThree = [[stepTwo objectAtIndex:0]objectForKey:@"teams"];
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
            
        } else if ([self.teamName isEqualToString:@"Pelicans"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0093B1);
            
        } else if ([self.teamName isEqualToString:@"Bulls"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            
        } else if ([self.teamName isEqualToString:@"Cavaliers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x061642);
            
        } else if ([self.teamName isEqualToString:@"Mavericks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0C479D);
            
        } else if ([self.teamName isEqualToString:@"Nuggets"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0860A8);
            
        } else if ([self.teamName isEqualToString:@"Pistons"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xFA002C);
            
        } else if ([self.teamName isEqualToString:@"Warriors"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x00275D);
            
        } else if ([self.teamName isEqualToString:@"Rockets"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xD40026);
            
        } else if ([self.teamName isEqualToString:@"Pacers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x061642);
            
        } else if ([self.teamName isEqualToString:@"Clippers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xFA0028);
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            
        } else if ([self.teamName isEqualToString:@"Lakers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x542582);
            
        }else if ([self.teamName isEqualToString:@"Heat"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            
        }else if ([self.teamName isEqualToString:@"Bucks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x003813);
            
        }else if ([self.teamName isEqualToString:@"Timberwolves"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0E3764);
            
        }else if ([self.teamName isEqualToString:@"Nets"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x06143F);
            
        }else if ([self.teamName isEqualToString:@"Knicks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x225EA8);
            
        }else if ([self.teamName isEqualToString:@"Magic"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0860A8);
            
        }else if ([self.teamName isEqualToString:@"76ers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            
        }else if ([self.teamName isEqualToString:@"Suns"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x23006A);
            
        }else if ([self.teamName isEqualToString:@"Kings"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x393996);
            
        }else if ([self.teamName isEqualToString:@"Spurs"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            
        }else if ([self.teamName isEqualToString:@"Thunder"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xC67C03);
            
        }else if ([self.teamName isEqualToString:@"Jazz"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x06143F);
            
        }else if ([self.teamName isEqualToString:@"Wizards"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0E3764);
            
        }else if ([self.teamName isEqualToString:@"Raptors"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xCE0F41);
            
        }else if ([self.teamName isEqualToString:@"Grizzlies"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x5D76A8);
            
        }else if ([self.teamName isEqualToString:@"Bobcats"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xFE3310);
            
        }
     

    }];
}



@end
