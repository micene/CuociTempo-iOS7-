//
//  Alimento.h
//  CuociTempo
//
//  Created by Michele Navolio on 09/11/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cottura, Tempo, Tipo;

@interface Alimento : NSManagedObject

@property (nonatomic, retain) NSNumber * alimentoid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Tipo *tipo;
@property (nonatomic, retain) NSSet *tempos;
@property (nonatomic, retain) NSSet *cotturas;
@end

@interface Alimento (CoreDataGeneratedAccessors)

- (void)addTemposObject:(Tempo *)value;
- (void)removeTemposObject:(Tempo *)value;
- (void)addTempos:(NSSet *)values;
- (void)removeTempos:(NSSet *)values;

- (void)addCotturasObject:(Cottura *)value;
- (void)removeCotturasObject:(Cottura *)value;
- (void)addCotturas:(NSSet *)values;
- (void)removeCotturas:(NSSet *)values;

@end
