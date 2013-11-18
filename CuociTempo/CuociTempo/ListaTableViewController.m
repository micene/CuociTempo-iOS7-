//
//  ListaTableViewController.m
//  CuociTempo
//
//  Created by Michele Navolio on 08/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import "ListaTableViewController.h"
#import "DataManager.h"
#import "Alimento.h"
#import "Tipo.h"
#import "TimerViewController.h"
#import "PesoViewController.h"

@interface ListaTableViewController (){

    UIAlertView * alert;
    BOOL isRunning;
    Alimento *a;

}
@end

@implementation ListaTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchedResultsController *fRC = [[DataManager sharedClass]fetchedEntityWithClassName:@"Alimento" sortDescriptorWithKey:@"tipo.nametype" sectionNameKeyPath:@"tipo.nametype" setPredicate:[NSPredicate predicateWithFormat:@"ANY self.cotturas.type == %@",self.title]];
    
    NSError *error;

    if(![fRC performFetch:&error]){
        NSLog(@"%@ %@",error,[error userInfo]);
    }
    
    self.swipeToBack = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [self.swipeToBack setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.tableView addGestureRecognizer:self.swipeToBack];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[DataManager sharedClass]nomePerSezione:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[DataManager sharedClass]numeroDiSezioni];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
 return [[DataManager sharedClass]numeroDiRighePerSezione:section];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Alimento *alimento = (Alimento*)[[DataManager sharedClass]configuraPerCella:indexPath];
    cell.textLabel.text = alimento.name;
    cell.detailTextLabel.text = alimento.tipo.nametype;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"tableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Alimento *alimento = (Alimento*)[[DataManager sharedClass]configuraPerCella:indexPath];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ThirdStoryboard" bundle:nil];
    
    if([self.title isEqualToString:@"Microonde"]){
        
        
        PesoViewController *peso = [storyBoard instantiateViewControllerWithIdentifier:@"PesoView"];
        
        peso.title = alimento.name;
        peso.cottura = self.title;
        
        [self.navigationController pushViewController:peso animated:NO];
        
    }else{
        if(!self.timer){
            self.timer = [storyBoard instantiateViewControllerWithIdentifier:@"TimerView"];
            self.timer.title = alimento.name;
            self.timer.cottura = self.title;
            self.timer.tempo = (Tempo*)[[DataManager sharedClass]tempoPerAlimento:[NSString stringWithFormat:@"cottura.type == '%@' AND alimento.name == '%@'",self.title,self.timer.title]];
        
            [self.navigationController pushViewController:self.timer animated:NO];
        }else{
            alert = [[UIAlertView alloc] initWithTitle:@"Alert1" //titolo bottone
                                               message:@"Timer Gia Avviato! Avviarne un altro?"  //messagio dato dal bottone
                                              delegate:self  //assegno a ql delegato deve lavorare          -----> FASE 2
                                     cancelButtonTitle:@"Cancella" //bottone negativo indice 0
                                     otherButtonTitles:@"Avvia",nil];
            a = alimento;
             //lancio il metodo show
            [alert show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"ho toccato %i",buttonIndex);
    if(alertView == alert) {  //controlliamo ql alert e stata scatenata
        switch (buttonIndex) {
            case 0:
                break;
            case 1:
                self.timer = [[UIStoryboard storyboardWithName:@"ThirdStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"TimerView"];
                self.timer.title = a.name;
                self.timer.cottura = self.title;
                [self.navigationController pushViewController:self.timer animated:NO];

                self.timer.tempo = (Tempo*)[[DataManager sharedClass]tempoPerAlimento:[NSString stringWithFormat:@"cottura.type == '%@' AND alimento.name == '%@'",self.title,self.timer.title]];
                break;
            default:
                break;
        }
        
    }
}

-(void)back:(UISwipeGestureRecognizer*)sender{

    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    if (sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"a");
    }
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
 
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark -
#pragma mark Fetched results controller

/*
 NSFetchedResultsController delegate methods to respond to additions, removals and so on.
 */

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{

    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}


@end
