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



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.swipeToBack = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [self.swipeToBack setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:self.swipeToBack];
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

-(void)back:(UISwipeGestureRecognizer*)sender{
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
    
}


@end
