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
#import "Twilinator.h"
#define accountSID @"AC4be7b47606401ee1b19d02fbf90cf503"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#define alkKey @"109293217ef79814ce683bcb933f7e41626180de"

@interface MainViewController ()

@end

@implementation MainViewController{
    int teamColor;
    BOOL switchButtonOff;
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
    [self playerMethod];
    self.infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [self.infoButton setFrame:CGRectMake(937, 268, 73, 44)];
    [self.infoButton setBackgroundColor:[UIColor clearColor]];
    [self.infoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.infoButton addTarget:self action:@selector(espnNews) forControlEvents:UIControlEventTouchUpInside];
    //[self.infoButton setTitle:@"info" forState:UIControlStateNormal];
    [self.view addSubview:self.infoButton];
    
    [self.ppgLabel setHidden:YES];
    [self.rpgLabel setHidden:YES];
    [self.apgLabel setHidden:YES];
    [self.paLabel setHidden:YES];
    
    [self.label1 setHidden:YES];
    [self.label2 setHidden:YES];
    [self.label3 setHidden:YES];
    [self.label4 setHidden:YES];
    [self.label5 setHidden:YES];
    
    [self.playerRPGLabel setHidden:YES];
    [self.playerPPGLabel setHidden:YES];
    [self.playerPERLabel setHidden:YES];
    [self.player3PLabel setHidden:YES];
    [self.playerAPGLabel setHidden:YES];
    
    [self.sentimentLabel setHidden:YES];
    [self.sentimentTitle setHidden:YES];
    
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
        
        self.espnNewsString = [[[[[stepThree objectAtIndex:0] objectForKey:@"links"]objectForKey:@"mobile"] objectForKey:@"teams"] objectForKey:@"href"];
        
        
        //NSLog(@"%@", stepThree);
        
        self.teamColor = [[stepThree objectAtIndex:0]objectForKey:@"color"];
        self.teamLocation = [[stepThree objectAtIndex:0]objectForKey:@"location"];
        self.teamName = [[stepThree objectAtIndex:0]objectForKey:@"name"];
        self.teamAbbreviation = [[stepThree objectAtIndex:0]objectForKey:@"abbreviation"];

        


        [[NSNotificationCenter defaultCenter]postNotificationName:@"JSONfinished" object:nil];
        

        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //
    }];
    [operation start];
   
    
    self.searchTextField.text = @"";
}

-(void)test{
    NSNotificationCenter *jsonNotification = [NSNotificationCenter defaultCenter];
    [jsonNotification addObserverForName:@"JSONfinished" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        
        NSString *combinedString = [self.teamLocation stringByAppendingString:[NSString stringWithFormat:@" %@", self.teamName]];
        self.teamLocationLabel.text = combinedString;
        
//        self.teamLocationLabel.text = self.teamLocation;
//        self.teamNameLabel.text = self.teamName;
        self.teamAbbreviationLabel.text = self.teamAbbreviation;
        
        
        
        if ([self.teamName isEqualToString:@"Bucks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x003813);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x003813);
            UIImage* image = [UIImage imageNamed: @"bucks.gif"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"12th";
            self.winsLabel.text = @"5th";
            self.lossesLabel.text = @"9th";
            self.pctLabel.text = @"20th";
            
        } else if ([self.teamName isEqualToString:@"Heat"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x000000);
            UIImage* image = [UIImage imageNamed: @"heat.png"];
            [self.teamLogo setImage:image];

            self.standingsLabel.text = @"5th";
            self.winsLabel.text = @"30th";
            self.lossesLabel.text = @"7th";
            self.pctLabel.text = @"5th";
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x002B5C);
            UIImage* image = [UIImage imageNamed: @"atlanta.gif"];
            [self.teamLogo setImage:image];

            self.standingsLabel.text = @"14th";
            self.winsLabel.text = @"23rd";
            self.lossesLabel.text = @"2nd";
            self.pctLabel.text = @"13th";
            
        } else if ([self.teamName isEqualToString:@"Celtics"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x006532);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x006532);
            UIImage* image = [UIImage imageNamed: @"celtics.png"];
            [self.teamLogo setImage:image];

            self.standingsLabel.text = @"18th";
            self.winsLabel.text = @"29th";
            self.lossesLabel.text = @"12th";
            self.pctLabel.text = @"12th";
            
        } else if ([self.teamName isEqualToString:@"Pelicans"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0093B1);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x0093B1);
            UIImage* image = [UIImage imageNamed: @"pelicans.png"];
            [self.teamLogo setImage:image];

            self.standingsLabel.text = @"25th";
            self.winsLabel.text = @"17th";
            self.lossesLabel.text = @"23rd";
            self.pctLabel.text = @"14th";
            
        } else if ([self.teamName isEqualToString:@"Bulls"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x000000);
            UIImage* image = [UIImage imageNamed: @"bulls.png"];
            [self.teamLogo setImage:image];

            self.standingsLabel.text = @"29th";
            self.winsLabel.text = @"8th";
            self.lossesLabel.text = @"8th";
            self.pctLabel.text = @"3rd";
            
        } else if ([self.teamName isEqualToString:@"Cavaliers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x061642);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x061642);
            UIImage* image = [UIImage imageNamed: @"cavaliers.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"19th";
            self.winsLabel.text = @"22nd";
            self.lossesLabel.text = @"26th";
            self.pctLabel.text = @"25th";
            
        } else if ([self.teamName isEqualToString:@"Mavericks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0C479D);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x0C479D);
            UIImage* image = [UIImage imageNamed: @"mavericks.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"8th";
            self.winsLabel.text = @"16th";
            self.lossesLabel.text = @"5th";
            self.pctLabel.text = @"27th";
            
        } else if ([self.teamName isEqualToString:@"Nuggets"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0860A8);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x0860A8);
            UIImage* image = [UIImage imageNamed: @"nuggets.gif"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"1st";
            self.winsLabel.text = @"2nd";
            self.lossesLabel.text = @"3rd";
            self.pctLabel.text = @"23rd";
            
        } else if ([self.teamName isEqualToString:@"Pistons"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xFA002C);
            self.teamLocationLabel.textColor = UIColorFromRGB(0xFA002C);
            UIImage* image = [UIImage imageNamed: @"pistons.gif"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"22nd";
            self.winsLabel.text = @"13th";
            self.lossesLabel.text = @"22nd";
            self.pctLabel.text = @"18th";
            
        } else if ([self.teamName isEqualToString:@"Warriors"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x00275D);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x00275D);
            UIImage* image = [UIImage imageNamed: @"warriors.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"7th";
            self.winsLabel.text = @"3rd";
            self.lossesLabel.text = @"15th";
            self.pctLabel.text = @"19th";
            
        } else if ([self.teamName isEqualToString:@"Rockets"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xD40026);
            self.teamLocationLabel.textColor = UIColorFromRGB(0xD40026);
            UIImage* image = [UIImage imageNamed: @"rockets.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"2nd";
            self.winsLabel.text = @"7th";
            self.lossesLabel.text = @"6th";
            self.pctLabel.text = @"28th";
            
        } else if ([self.teamName isEqualToString:@"Pacers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x061642);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x061642);
            UIImage* image = [UIImage imageNamed: @"pacers.gif"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"23rd";
            self.winsLabel.text = @"1st";
            self.lossesLabel.text = @"28th";
            self.pctLabel.text = @"2nd";
            
        } else if ([self.teamName isEqualToString:@"Clippers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xFA0028);
            self.teamLocationLabel.textColor = UIColorFromRGB(0xFA0028);
            UIImage* image = [UIImage imageNamed: @"clippers.gif"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"9th";
            self.winsLabel.text = @"18th";
            self.lossesLabel.text = @"4th";
            self.pctLabel.text = @"4th";
            
        } else if ([self.teamName isEqualToString:@"Hawks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x002B5C);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x002B5C);
            UIImage* image = [UIImage imageNamed: @"atlanta.gif"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"14th";
            self.winsLabel.text = @"23rd";
            self.lossesLabel.text = @"2nd";
            self.pctLabel.text = @"13th";
            
        } else if ([self.teamName isEqualToString:@"Lakers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x542582);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x542582);
            UIImage* image = [UIImage imageNamed: @"lakers.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"6th";
            self.winsLabel.text = @"4th";
            self.lossesLabel.text = @"17th";
            self.pctLabel.text = @"22nd";
            
        }else if ([self.teamName isEqualToString:@"Heat"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x000000);
            UIImage* image = [UIImage imageNamed: @"heat.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"5th";
            self.winsLabel.text = @"30th";
            self.lossesLabel.text = @"7th";
            self.pctLabel.text = @"5th";
            
        }else if ([self.teamName isEqualToString:@"Bucks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x003813);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x003813);
            UIImage* image = [UIImage imageNamed: @"bucks.gif"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"12th";
            self.winsLabel.text = @"5th";
            self.lossesLabel.text = @"9th";
            self.pctLabel.text = @"20th";
            
        }else if ([self.teamName isEqualToString:@"Timberwolves"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0E3764);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x0E3764);
            UIImage* image = [UIImage imageNamed: @"timberwolves.gif"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"20th";
            self.winsLabel.text = @"14th";
            self.lossesLabel.text = @"16th";
            self.pctLabel.text = @"15th";
            
        }else if ([self.teamName isEqualToString:@"Nets"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x06143F);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x06143F);
            UIImage* image = [UIImage imageNamed: @"nets.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"17th";
            self.winsLabel.text = @"10th";
            self.lossesLabel.text = @"27th";
            self.pctLabel.text = @"6th";
            
        }else if ([self.teamName isEqualToString:@"Knicks"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x225EA8);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x225EA8);
            UIImage* image = [UIImage imageNamed: @"knicks.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"11th";
            self.winsLabel.text = @"26th";
            self.lossesLabel.text = @"30th";
            self.pctLabel.text = @"7th";
            
        }else if ([self.teamName isEqualToString:@"Magic"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0860A8);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x0860A8);
            UIImage* image = [UIImage imageNamed: @"magic.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"24th";
            self.winsLabel.text = @"12th";
            self.lossesLabel.text = @"10th";
            self.pctLabel.text = @"24th";
            
        }else if ([self.teamName isEqualToString:@"76ers"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x000000);
            UIImage* image = [UIImage imageNamed: @"76ers.gif"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"30th";
            self.winsLabel.text = @"20th";
            self.lossesLabel.text = @"11th";
            self.pctLabel.text = @"9th";
            
        }else if ([self.teamName isEqualToString:@"Suns"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x23006A);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x23006A);
            UIImage* image = [UIImage imageNamed: @"suns.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"21st";
            self.winsLabel.text = @"18th";
            self.lossesLabel.text = @"14th";
            self.pctLabel.text = @"26th";
            
        }else if ([self.teamName isEqualToString:@"Kings"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x393996);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x393996);
            UIImage* image = [UIImage imageNamed: @"kings.gif"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"10th";
            self.winsLabel.text = @"25th";
            self.lossesLabel.text = @"25th";
            self.pctLabel.text = @"30th";
            
        }else if ([self.teamName isEqualToString:@"Spurs"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x000000);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x000000);
            UIImage* image = [UIImage imageNamed: @"spurs.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"4th";
            self.winsLabel.text = @"21st";
            self.lossesLabel.text = @"1st";
            self.pctLabel.text = @"11th";
            
        }else if ([self.teamName isEqualToString:@"Thunder"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xC67C03);
            self.teamLocationLabel.textColor = UIColorFromRGB(0xC67C03);
            UIImage* image = [UIImage imageNamed: @"thunder.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"3rd";
            self.winsLabel.text = @"6th";
            self.lossesLabel.text = @"21st";
            self.pctLabel.text = @"9th";
            
        }else if ([self.teamName isEqualToString:@"Jazz"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x06143F);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x06143F);
            UIImage* image = [UIImage imageNamed: @"jazz.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"13th";
            self.winsLabel.text = @"14th";
            self.lossesLabel.text = @"13th";
            self.pctLabel.text = @"15th";
            
        }else if ([self.teamName isEqualToString:@"Wizards"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x0E3764);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x0E3764);
            UIImage* image = [UIImage imageNamed: @"wizards.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"28th";
            self.winsLabel.text = @"9th";
            self.lossesLabel.text = @"19th";
            self.pctLabel.text = @"8th";
            
        }else if ([self.teamName isEqualToString:@"Raptors"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xCE0F41);
            self.teamLocationLabel.textColor = UIColorFromRGB(0xCE0F41);
            UIImage* image = [UIImage imageNamed: @"raptors.gif"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"16th";
            self.winsLabel.text = @"28th";
            self.lossesLabel.text = @"20th";
            self.pctLabel.text = @"17th";
            
        }else if ([self.teamName isEqualToString:@"Grizzlies"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0x5D76A8);
            self.teamLocationLabel.textColor = UIColorFromRGB(0x5D76A8);
            UIImage* image = [UIImage imageNamed: @"grizzlies.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"27th";
            self.winsLabel.text = @"11th";
            self.lossesLabel.text = @"24th";
            self.pctLabel.text = @"1st";
            
        }else if ([self.teamName isEqualToString:@"Bobcats"]) {
            self.teamNameLabel.textColor = UIColorFromRGB(0xFE3310);
            self.teamLocationLabel.textColor = UIColorFromRGB(0xFE3310);
            UIImage* image = [UIImage imageNamed: @"bobcats.png"];
            [self.teamLogo setImage:image];
            
            self.standingsLabel.text = @"26th";
            self.winsLabel.text = @"27th";
            self.lossesLabel.text = @"29th";
            self.pctLabel.text = @"29th";
            
        }
        [self.ppgLabel setHidden:NO];
        [self.rpgLabel setHidden:NO];
        [self.apgLabel setHidden:NO];
        [self.paLabel setHidden:NO];

    }];
}

- (IBAction)switchButtonPressed:(id)sender{
    if (switchButtonOff == YES) {
        [self.playerSearchButton setHidden:YES];
        [self.playerTextField setHidden:YES];
        [self.switchButton setTitle:@"Off" forState:UIControlStateNormal];
        [self.playerNameLabel setHidden:YES];
        
        [self.label1 setHidden:YES];
        [self.label2 setHidden:YES];
        [self.label3 setHidden:YES];
        [self.label4 setHidden:YES];
        [self.label5 setHidden:YES];
        
        [self.playerRPGLabel setHidden:YES];
        [self.playerPPGLabel setHidden:YES];
        [self.playerPERLabel setHidden:YES];
        [self.player3PLabel setHidden:YES];
        [self.playerAPGLabel setHidden:YES];
        
        [self.sentimentLabel setHidden:YES];
        [self.sentimentTitle setHidden:YES];
        
        switchButtonOff = FALSE;
        
    } else if (switchButtonOff == FALSE) {
        [self.playerSearchButton setHidden:NO];
        [self.playerTextField setHidden:NO];
        [self.switchButton setTitle:@"On" forState:UIControlStateNormal];
        [self.playerNameLabel setHidden:NO];
        
        [self.label1 setHidden:NO];
        [self.label2 setHidden:NO];
        [self.label3 setHidden:NO];
        [self.label4 setHidden:NO];
        [self.label5 setHidden:NO];
        
        [self.playerRPGLabel setHidden:NO];
        [self.playerPPGLabel setHidden:NO];
        [self.playerPERLabel setHidden:NO];
        [self.player3PLabel setHidden:NO];
        [self.playerAPGLabel setHidden:NO];
        
        [self.sentimentLabel setHidden:NO];
        [self.sentimentTitle setHidden:NO];
        
        switchButtonOff = TRUE;
    }
    
        

}

- (IBAction)playerButtonPressed:(id)sender{
    [self.playerTextField resignFirstResponder];
    
    NSString *encodedString = [self.playerTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.playerName = self.playerTextField.text;
    
    if ([self.playerName isEqualToString:@"Lebron James"]) {
        self.playerID = @"1966";
        self.playerPPGLabel.text = @"26.8";
        self.playerAPGLabel.text = @"7.3";
        self.playerPERLabel.text = @"32%";
        self.player3PLabel.text = @"33%";
        self.playerRPGLabel.text = @"8";
        self.sentimentString = @"http://www.nydailynews.com/sports/basketball/heat-shoot-straight-spurs-facing-must-win-article-1.1373894";
        
    } else if ([self.playerName isEqualToString:@"Mario Chalmers"]) {
        self.playerID = @"3419";
        self.playerPPGLabel.text = @"8.6";
        self.playerAPGLabel.text = @"3.5";
        self.playerPERLabel.text = @"13%";
        self.player3PLabel.text = @"37%";
        self.playerRPGLabel.text = @"2";
        self.sentimentString = @"http://www.miamiherald.com/2013/06/14/3450608/miami-heats-mario-chalmers-heats.html";

        
    } else if ([self.playerName isEqualToString:@"Dwayne Wade"]) {
        self.playerID = @"1987";
        self.playerPPGLabel.text = @"21.2";
        self.playerAPGLabel.text = @"5.1";
        self.playerPERLabel.text = @"24%";
        self.player3PLabel.text = @"28%";
        self.playerRPGLabel.text = @"5";
        self.sentimentString = @"http://bostonherald.com/sports/celtics_nba/nba_coverage/2013/06/in_tied_nba_finals_wade_says_game_5_could_be_best";

        
    } else if ([self.playerName isEqualToString:@"Chris Bosh"]) {
        self.playerID = @"1977";
        self.playerPPGLabel.text = @"16.6";
        self.playerAPGLabel.text = @"1.1";
        self.playerPERLabel.text = @"50%";
        self.player3PLabel.text = @"28%";
        self.playerRPGLabel.text = @"6.8";
        self.sentimentString = @"http://www.usatoday.com/story/sports/nba/playoffs/2013/06/14/chris-bosh-finals-miami-heat-vs-san-antonio-spurs/2425337/";

        
    } else if ([self.playerName isEqualToString:@"Tony Parker"]) {
        self.playerID = @"1015";
        self.playerPPGLabel.text = @"20.3";
        self.playerAPGLabel.text = @"7.6";
        self.playerPERLabel.text = @"23%";
        self.player3PLabel.text = @"31%";
        self.playerRPGLabel.text = @"3";
        self.sentimentString = @"http://www.usatoday.com/story/sports/nba/spurs/2013/06/15/spurs-parker-sore-hamstring-can-tear-any-time/2426979/";

        
    } else if ([self.playerName isEqualToString:@"Tim Duncan"]) {
        self.playerID = @"215";
        self.playerPPGLabel.text = @"17.8";
        self.playerAPGLabel.text = @"3.1";
        self.playerPERLabel.text = @"50%";
        self.player3PLabel.text = @"18%";
        self.playerRPGLabel.text = @"10";
        self.sentimentString = @"http://www.usatoday.com/story/sports/nba/playoffs/2013/06/13/tim-duncan-championships-titles-finals-miami-heat-vs-san-antonio-spurs/2420577/";

        
    } else if ([self.playerName isEqualToString:@"Kawhi Leonard"]) {
        self.playerID = @"6450";
        self.playerPPGLabel.text = @"11.9";
        self.playerAPGLabel.text = @"1.6";
        self.playerPERLabel.text = @"16%";
        self.player3PLabel.text = @"37%";
        self.playerRPGLabel.text = @"6";
        self.sentimentString = @"http://bleacherreport.com/articles/1672784-what-are-kawhi-leonard-and-danny-greens-pro-ceilings";
    }



    
    NSString *jsonEscapeString = @"%2Fjson";
    NSString *searchString = [NSString stringWithFormat:@"http://api.espn.com/v1/sports/basketball/nba/athletes/%@?_accept=application%@&apikey=%@",self.playerID, jsonEscapeString, espnAPIKey];
    
    NSURL *url = [NSURL URLWithString:searchString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
       // NSLog(@"%@", JSON);
        NSDictionary *results = JSON;
        NSArray *resultsArray = [results objectForKey:@"sports"];
        NSDictionary *stepOne = [resultsArray objectAtIndex:0];
        NSArray *stepTwo = [stepOne objectForKey:@"leagues"];
        NSArray *stepThree = [[stepTwo objectAtIndex:0]objectForKey:@"athletes"];
        
        //NSLog(@"%@", stepThree);
        self.playerName = [[stepThree objectAtIndex:0]objectForKey:@"fullName"];
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"JSON" object:nil];
        
        NSLog(@"player name = %@", self.playerName);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failure in player search");
        
        

    }];
    
    [operation start];
    [self alchemy];
    
    self.playerTextField.text = @"";
}

- (void)alchemy{
    
    NSString *searchString = [NSString stringWithFormat:@"http://access.alchemyapi.com/calls/url/URLGetTextSentiment?apikey=%@&url=%@&outputMode=json",alkKey, self.sentimentString];
    
    NSURL *url = [NSURL URLWithString:searchString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"%@", JSON);
        NSDictionary *results = JSON;
        NSString *sentimentString = [[results objectForKey:@"docSentiment"] objectForKey:@"type"];
        
        NSLog(@"sentiment string = %@", sentimentString);
        
        self.sentimentLabel.text = sentimentString;
        
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failure in alchemy search");
        
    }];
    
    [operation start];
}

-(void) espnNews{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.espnNewsString]];
}
-(void)playerMethod{
    NSNotificationCenter *newNotification = [NSNotificationCenter defaultCenter];
    [newNotification addObserverForName:@"JSON" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        self.playerNameLabel.text = self.playerName;
        NSLog(@"player method ran");
    }];

//        self.playerNameLabel.text = self.playerName;
//        NSLog(@"Player Method Ran");


}

- (IBAction)onBlastButtonPressed:(id)sender{
    [self.onBlastTextField resignFirstResponder];
    
    __block ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.twilio.com/2010-04-01/Accounts/%@/SMS/Messages.json", accountSID]]];
    
    [request setUsername:@"AC4be7b47606401ee1b19d02fbf90cf503"];
    [request setPassword:@"bca2e53769fca182d4fd4f03250654d8"];
    
    [request addPostValue:@"19138711246" forKey:@"From"];
    [request addPostValue:@"19139541845" forKey:@"To"];
    [request addPostValue:self.onBlastTextField.text forKey:@"Body"];
    
    [request setCompletionBlock:^(){
        SBJsonParser *parser = [[SBJsonParser alloc] init];
//        NSDictionary *responseDict = [parser objectWithString:request.responseString];
//        handler( responseDict, nil );
        
    }];
    
    [request setFailedBlock:^(){
//        handler( nil, request.error );
    }];
    
    [request startAsynchronous];
    self.onBlastTextField.text = @"";
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 160) ? NO : YES;
}


@end
