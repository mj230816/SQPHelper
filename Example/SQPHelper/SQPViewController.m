//
//  SQPViewController.m
//  SQPHelper
//
//  Created by mj230816 on 10/11/2017.
//  Copyright (c) 2017 mj230816. All rights reserved.
//

#import "SQPViewController.h"
#import <SQPHelper/Manager.h>


@interface SQPViewController ()

@end

@implementation SQPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
}
- (IBAction)button:(id)sender {
    
    id vc = [[UIViewController alloc] initWithNibName:@"aaViewController"
                                               bundle:[Manager bundle]];
    [self presentViewController:vc
                       animated:YES
                     completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
