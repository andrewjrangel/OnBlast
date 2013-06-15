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
        self.espnNewsArray = [[[[[stepThree objectAtIndex:0] objectForKey:@"links"]objectForKey:@"mobile"] objectForKey:@"teams"] objectForKey:@"href"];
        self.espnNotesArray = [[[[[stepThree objectAtIndex:0] objectForKey:@"links"]objectForKey:@"api"] objectForKey:@"notes"] objectForKey:@"href"];
        self.espnTeamsArray = [[[[[stepThree objectAtIndex:0] objectForKey:@"links"]objectForKey:@"api"] objectForKey:@"teams"] objectForKey:@"href"];
        
        self.espnNewsString = [NSString stringWithFormat:@"%@", self.espnNewsArray];
        self.espnNotesString = [NSString stringWithFormat:@"%@", self.self.espnNotesArray];
        self.espnTeamsString = [NSString stringWithFormat:@"%@", self.espnTeamsArray];
        
        
        NSLog(@"%@", stepThree);
        
        self.teamColor = [[stepThree objectAtIndex:0]objectForKey:@"color"];
        self.teamLocation = [[stepThree objectAtIndex:0]objectForKey:@"location"];
        self.teamName = [[stepThree objectAtIndex:0]objectForKey:@"name"];
        self.teamAbbreviation = [[stepThree objectAtIndex:0]objectForKey:@"abbreviation"];

        


        [[NSNotificationCenter defaultCenter]postNotificationName:@"JSONfinished" object:nil];
        

        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //
    }];
    [operation start];
   
    
    
    
}

-(void)test{
    NSNotificationCenter *jsonNotification = [NSNotificationCenter defaultCenter];
    [jsonNotification addObserverForName:@"JSONfinished" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {

        UIButton *btnFaceBook = [UIButton buttonWithType:UIButtonTypeInfoDark];
        [btnFaceBook setFrame:CGRectMake(800, 500, 280, 30)];
        [btnFaceBook setBackgroundColor:[UIColor clearColor]];
        [btnFaceBook.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [btnFaceBook addTarget:self action:@selector(espnNews) forControlEvents:UIControlEventTouchUpInside];
        [btnFaceBook setTitle:@"ESPN News" forState:UIControlStateNormal];
        [self.view addSubview:btnFaceBook];
        
        
//        NSLog(@"%@", self.teamName);
//        NSLog(@"%@", self.teamColor);
//        NSLog(@"%@", self.teamLocation);
        
        self.teamLocationLabel.text = self.teamLocation;
        self.teamNameLabel.text = self.teamName;
        self.teamAbbreviationLabel.text = self.teamAbbreviation;
        self.linksLabel1.text = self.espnNewsString;
        self.linksLabel2.text = self.espnNotesString;
        self.linksLabel3.text = self.espnTeamsString;
        
        
        if ([self.teamName isEqualToString:@"Bucks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x003813);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x003813);
            UIImage* image = [UIImage imageNamed: @"bucks.gif"];
            [self.teamLogo setImage:image];

            
        } else if ([self.teamName isEqualToString:@"Heat"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x000000);
            UIImage* image = [UIImage imageNamed: @"heat.gif"];
            [self.teamLogo setImage:image];

            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x002B5C);
            UIImage* image = [UIImage imageNamed: @"hawks.gif"];
            [self.teamLogo setImage:image];

            
        } else if ([self.teamName isEqualToString:@"Celtics"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x006532);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x006532);
            UIImage* image = [UIImage imageNamed: @"celtics.gif"];
            [self.teamLogo setImage:image];

            
        } else if ([self.teamName isEqualToString:@"Pelicans"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0093B1);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x0093B1);
            UIImage* image = [UIImage imageNamed: @"pelicans.png"];
            [self.teamLogo setImage:image];

            
        } else if ([self.teamName isEqualToString:@"Bulls"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x000000);
            UIImage* image = [UIImage imageNamed: @"bulls.gif"];
            [self.teamLogo setImage:image];

            
        } else if ([self.teamName isEqualToString:@"Cavaliers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x061642);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x061642);
            UIImage* image = [UIImage imageNamed: @"cavaliers.gif"];
            [self.teamLogo setImage:image];
            
        } else if ([self.teamName isEqualToString:@"Mavericks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0C479D);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x0C479D);
            UIImage* image = [UIImage imageNamed: @"mavericks.gif"];
            [self.teamLogo setImage:image];
            
        } else if ([self.teamName isEqualToString:@"Nuggets"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0860A8);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x0860A8);
            UIImage* image = [UIImage imageNamed: @"denver.gif"];
            [self.teamLogo setImage:image];
            
        } else if ([self.teamName isEqualToString:@"Pistons"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xFA002C);
            self.teamLocationLabel.textColor = UIColorFromRGB(0xFA002C);
            UIImage* image = [UIImage imageNamed: @"detroit.gif"];
            [self.teamLogo setImage:image];
            
        } else if ([self.teamName isEqualToString:@"Warriors"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x00275D);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x00275D);
            UIImage* image = [UIImage imageNamed: @"goldenState.gif"];
            [self.teamLogo setImage:image];
            
        } else if ([self.teamName isEqualToString:@"Rockets"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xD40026);
            self.teamLocationLabel.textColor = UIColorFromRGB(0xD40026);
            UIImage* image = [UIImage imageNamed: @"houston.gif"];
            [self.teamLogo setImage:image];
            
        } else if ([self.teamName isEqualToString:@"Pacers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x061642);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x061642);
            UIImage* image = [UIImage imageNamed: @"pacers.gif"];
            [self.teamLogo setImage:image];
            
        } else if ([self.teamName isEqualToString:@"Clippers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xFA0028);
            self.teamLocationLabel.textColor = UIColorFromRGB(0xFA0028);
            UIImage* image = [UIImage imageNamed: @"clippers.gif"];
            [self.teamLogo setImage:image];
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x002B5C);
            UIImage* image = [UIImage imageNamed: @"atlanta.gif"];
            [self.teamLogo setImage:image];
            
        } else if ([self.teamName isEqualToString:@"Lakers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x542582);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x542582);
            UIImage* image = [UIImage imageNamed: @"lakers.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Heat"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x000000);
            UIImage* image = [UIImage imageNamed: @"heat.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Bucks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x003813);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x003813);
            UIImage* image = [UIImage imageNamed: @"bucks.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Timberwolves"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0E3764);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x0E3764);
            UIImage* image = [UIImage imageNamed: @"timberwolves.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Nets"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x06143F);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x06143F);
            UIImage* image = [UIImage imageNamed: @"nets.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Knicks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x225EA8);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x225EA8);
            UIImage* image = [UIImage imageNamed: @"knicks.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Magic"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0860A8);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x0860A8);
            UIImage* image = [UIImage imageNamed: @"magic.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"76ers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x000000);
            UIImage* image = [UIImage imageNamed: @"76ers.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Suns"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x23006A);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x23006A);
            UIImage* image = [UIImage imageNamed: @"suns.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Kings"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x393996);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x393996);
            UIImage* image = [UIImage imageNamed: @"kings.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Spurs"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x000000);
            UIImage* image = [UIImage imageNamed: @"spurs.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Thunder"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xC67C03);
            self.teamLocationLabel.textColor = UIColorFromRGB(0xC67C03);
            UIImage* image = [UIImage imageNamed: @"thunder.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Jazz"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x06143F);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x06143F);
            UIImage* image = [UIImage imageNamed: @"jazz.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Wizards"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0E3764);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x0E3764);
            UIImage* image = [UIImage imageNamed: @"wizards.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Raptors"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xCE0F41);
            self.teamLocationLabel.textColor = UIColorFromRGB(0xCE0F41);
            UIImage* image = [UIImage imageNamed: @"raptors.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Grizzlies"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x5D76A8);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x5D76A8);
            UIImage* image = [UIImage imageNamed: @"grizzlies.gif"];
            [self.teamLogo setImage:image];
            
        }else if ([self.teamName isEqualToString:@"Bobcats"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xFE3310);
            self.teamLocationLabel.textColor = UIColorFromRGB(0xFE3310);
            UIImage* image = [UIImage imageNamed: @"Bobcats"];
            [self.teamLogo setImage:image];
            
        }
     

    }];
}


@end
