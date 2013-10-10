//
//  PressioneViewController.m
//  CuociTempo
//
//  Created by Michele Navolio on 08/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import "PressioneViewController.h"
#import "ListaTableViewController.h"

@interface PressioneViewController ()

@end

@implementation PressioneViewController



- (void)viewDidLoad
{

    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(60,60,100,100)];
    view.backgroundColor = [UIColor blackColor];
    
    UIImageView* cuoci = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];

    [view addSubview:cuoci];
    
    [self.view addSubview:view];
    
    [view setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0]];
    cuoci.alpha = 0;
    cuoci.image = [UIImage imageNamed:[NSString stringWithFormat:@"cuocitempo.jpg"]];
    
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:3.0];
    cuoci.alpha = 1.0;
    [view setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [UIView commitAnimations];
    
    self.swipeToBack = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [self.swipeToBack setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:self.swipeToBack];

    [super viewDidLoad];


    
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
    transition.subtype = kCATransitionFromRight;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

- (IBAction)vaiLista:(id)sender {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SecondStoryboard" bundle:nil];
        
        ListaTableViewController * lista = [sb instantiateViewControllerWithIdentifier:@"Lista"];
        
        [self.navigationController pushViewController:lista animated:YES];
}

@end
