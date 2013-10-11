//
//  PesoViewController.m
//  CuociTempo
//
//  Created by Michele Navolio on 10/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import "PesoViewController.h"
#import "TimerViewController.h"

@interface PesoViewController ()

@end

@implementation PesoViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"goToTimer"]) {
        
        TimerViewController *time = segue.destinationViewController;
    }
}

@end
