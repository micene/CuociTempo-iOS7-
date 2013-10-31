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

-(NSString*)tempoPerAlimento:(NSPredicate*)predicate;

-(NSManagedObjectContext*)managedObjectContext;



-(NSInteger)numerodiEntita:(NSInteger)sezione predicate:(NSPredicate*)predicate;
-(NSManagedObject*)fetchRequestPerCella:(unsigned int)cell predicate:(NSPredicate*)predicate;



-(NSFetchedResultsController *)fetchedResultsController;
-(NSFetchedResultsController *)fetchedEntityWithClassName:(NSString *)className
                                  sortDescriptorWithKey:(NSString *)sortDescriptors
                                     sectionNameKeyPath:(NSString *)sectionNameKeypath
                                             setPredicate:(NSPredicate *)predicate;

-(NSInteger)numeroDiSezioni;
-(NSInteger)numeroDiRighePerSezione:(NSInteger)sezione;
-(NSManagedObject*)configuraPerCella:(NSIndexPath*)cella;
-(NSString*)nomePerSezione:(NSInteger)sezione;
//-(void)creaAlimento:(NSString*)nome tipo:(NSString*)typeName cottura:(NSString*)typeCottura tempo:(NSString*)time;


@end
