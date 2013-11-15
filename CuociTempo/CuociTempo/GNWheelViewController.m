//
//  GNViewController.m
//  WheelComponent
//
//  Copyright (c) 2012 Ahmed Ragab
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "GNWheelViewController.h"
#import "ListaTableViewController.h"
#import "PesoViewController.h"
#import "DataManager.h"
#import "Alimento.h"
#import "TimerViewController.h"
#import <QuartzCore/QuartzCore.h>

static NSString *cott;

@implementation GNWheelViewController


@synthesize fetchObject = _fetchObject;
@synthesize cottura;

//iniziallizzo la view
- (GNWheelView *)wheelView{
    
    return (GNWheelView *)self.view;
}

//al caricamento della view
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //inizializzo la imageview
    /*UIImageView *cuoci = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.wheelView addSubview:cuoci];
    
    
    [self.wheelView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0]];
    cuoci.alpha = 1;
    cuoci.image = [UIImage imageNamed:[NSString stringWithFormat:@"cuocitempo.jpg"]];
    
    //inizio dell animazione che porta alla scomparsa della image view
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:2.5];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    cuoci.alpha = 0.0;
    
    [self.wheelView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    
    [UIView commitAnimations];*/
    
    NSLog(@"cottura %@",self.cottura);
    
    self.fetchObject = [[DataManager sharedClass]fetchaRequest:@"Alimento" predicate:[NSString stringWithFormat:@"(0 != SUBQUERY(tipo,$x,$x.nametype == '%@')) AND (0 != SUBQUERY(cotturas,$y,$y.type == '%@'))",self.title,self.cottura]];
    
}

//qnd la view e connessa
- (void)viewDidAppear:(BOOL)animated{
    
    self.wheelView.delegate = self;
    
    self.wheelView.idleDuration = 0;
    
    [self.wheelView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//qnd si gira il device
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}
//-----------------------------------

//numero di righe
- (unsigned int)numberOfRowsOfWheelView:(GNWheelView *)wheelView{
    
    return [[DataManager sharedClass]numerodiEntitaFromFetch:self.fetchObject sezione:0];
    
}

//cella che appare
- (UIView *)wheelView:(GNWheelView *)wheelView viewForRowAtIndex:(unsigned int)index{
    
    Alimento *alimento =(Alimento*)[[DataManager sharedClass]managedObjectFromFetch:self.fetchObject cell:index];
    
    UILabel *label = [[UILabel alloc]initWithFrame:wheelView.frame];
    
    label.text = alimento.name;
    
    return label;
    
}

//qnd seleziono una cella
- (void)wheelView:(GNWheelView *)wheelView didSelectedRowAtIndex:(unsigned int)index{
    
    Alimento *alimento = (Alimento*)[[DataManager sharedClass]managedObjectFromFetch:self.fetchObject cell:index];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ThirdStoryboard" bundle:nil];

    if([self.cottura isEqualToString:@"Microonde"]){
        
        
        PesoViewController *peso = [storyBoard instantiateViewControllerWithIdentifier:@"PesoView"];
        
        peso.title = alimento.name;
        peso.cottura = self.cottura;

        
        [self.navigationController pushViewController:peso animated:NO];
        
    }else{
        
        TimerViewController *timer = [storyBoard instantiateViewControllerWithIdentifier:@"TimerView"];
        
        timer.title = alimento.name;
        timer.cottura = self.cottura;
        
        [self.navigationController pushViewController:timer animated:NO];
        
    }
    
}

//-------------------------------------

//larghezza righe
- (float)rowWidthInWheelView:(GNWheelView *)wheelView{
    
    return 300;
    
}
//altezza righe
- (float)rowHeightInWheelView:(GNWheelView *)wheelView{
    
    return 83;
    
}

//--------------------------------------

- (BOOL)wheelView:(GNWheelView *)wheelView shouldEnterIdleStateForRowAtIndex:(unsigned int)index animated:(BOOL *)animated{
    
    return NO;
}

- (UIView *)wheelView:(GNWheelView *)wheelView idleStateViewForRowAtIndex:(unsigned int)index{
    
    return nil;
}

- (void)wheelView:(GNWheelView *)wheelView didStartIdleStateForRowAtIndex:(unsigned int)index{
    
    
}

//---------------------------------------

-(void)goToListaFrom:(GNWheelView *)wheelView{
    
    ListaTableViewController *lista = [[UIStoryboard storyboardWithName:@"SecondStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"Lista"];
    
    lista.title = self.title;
    [self.navigationController pushViewController:lista animated:YES];
    
}

-(void)swipeToHome:(GNWheelView *)wheelView{
    
        CATransition* transition = [CATransition animation];
        transition.duration = 0.3;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController popViewControllerAnimated:NO];
    
}

//----------------------------------


@end
