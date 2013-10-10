//
//  MicroViewController.m
//  CuociTempo
//
//  Created by Michele Navolio on 08/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import "MicroViewController.h"

@interface MicroViewController ()

@end

@implementation MicroViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.swipeToBack = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [self.swipeToBack setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:self.swipeToBack];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back:(UISwipeGestureRecognizer*)sender{
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popToRootViewControllerAnimated:NO];

}


@end
