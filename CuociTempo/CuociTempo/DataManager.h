//
//  DataManager.h
//  CuociTempo
//
//  Created by Michele Navolio on 20/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Alimento,Cottura;

@interface DataManager : NSObject<NSFetchedResultsControllerDelegate>

@property (nonatomic,retain)NSFetchedResultsController *fetchedResultsController;


+(DataManager*)sharedClass;
-(void)setup;

-(NSString*)tempoPerAlimento:(NSString*)predicateString;

-(NSManagedObjectContext*)managedObjectContext;


//-----------------------------------------
-(NSInteger)numerodiEntita:(NSString*)className sezione:(NSInteger)sezione predicate:(NSString*)predicateString;

-(NSManagedObject*)fetchRequestPerCella:(NSString*)className cell:(unsigned int)cell predicate:(NSString*)predicateString;

//--------------------

-(NSFetchedResultsController *)fetchedResultsController;
-(NSFetchedResultsController *)fetchedEntityWithClassName:(NSString *)className
                                  sortDescriptorWithKey:(NSString *)sortDescriptors
                                     sectionNameKeyPath:(NSString *)sectionNameKeypath
                                             setPredicate:(NSPredicate *)predicate;

-(NSInteger)numeroDiSezioni;
-(NSInteger)numeroDiRighePerSezione:(NSInteger)sezione;
-(NSString*)nomePerSezione:(NSInteger)sezione;
//-------------------
-(NSManagedObject*)configuraPerCella:(NSIndexPath*)cella;


@end
