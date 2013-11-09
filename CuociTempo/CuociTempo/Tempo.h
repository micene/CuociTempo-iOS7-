//
//  Tempo.h
//  CuociTempo
//
//  Created by Michele Navolio on 09/11/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Alimento, Cottura, Peso;

@interface Tempo : NSManagedObject

@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSNumber * tempoid;
@property (nonatomic, retain) Cottura *cottura;
@property (nonatomic, retain) Peso *peso;
@property (nonatomic, retain) Alimento *alimento;

@end
