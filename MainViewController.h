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

- (IBAction)searchButtonPressed:(id)sender;

@end
