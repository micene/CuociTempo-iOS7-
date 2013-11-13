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
{
    int peso;
}
@end

@implementation PesoViewController
@synthesize cottura;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.swipeToBack = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [self.swipeToBack setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:self.swipeToBack];
	// Do any additional setup after loading the view.
}

- (IBAction)selezionaPeso:(UISegmentedControl*)sender {
    
    peso = sender.selectedSegmentIndex;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"goToTimer"]) {
        
        TimerViewController *time = segue.destinationViewController;
        time.peso = peso;
        time.title = self.title;
        time.cottura = self.cottura;
    }
}

-(void)back:(UISwipeGestureRecognizer*)sender{
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
    
}


@end
