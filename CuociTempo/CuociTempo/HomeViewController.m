//
//  HomeViewController.m
//  CuociTempo
//
//  Created by Michele Navolio on 08/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import "HomeViewController.h"

#import "SearchViewController.h"
#import "GNWheelView.h"
#import "GNWheelViewController.h"

#import "MicroViewController.h"
#import "PressioneViewController.h"
#import "NormaleViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.swipeSearch = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeSearched:)];
    [self.swipeSearch setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:self.swipeSearch];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressionePushed:(UIButton*)sender {
    
    
    //PressioneViewController *pressione = [self.storyboard instantiateViewControllerWithIdentifier:@"Pressione"];
    GNWheelViewController *wheel = [self.storyboard instantiateViewControllerWithIdentifier:@"Wheel"];
    wheel.title = [sender currentTitle];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.6;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:wheel animated:NO];
    
}



- (IBAction)microPushed:(id)sender {
    
    MicroViewController *micro = [self.storyboard instantiateViewControllerWithIdentifier:@"Micro"];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.6;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:micro animated:NO];
}
- (IBAction)normalePushed:(id)sender {
    
    NormaleViewController *normale = [self.storyboard instantiateViewControllerWithIdentifier:@"Normale"];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.6;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:normale animated:NO];
}

-(void)swipeSearched:(UISwipeGestureRecognizer*)sender{
    
    SearchViewController *sv = [self.storyboard instantiateViewControllerWithIdentifier:@"Search"];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.6;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [self.navigationController pushViewController:sv animated:NO];

}
@end
