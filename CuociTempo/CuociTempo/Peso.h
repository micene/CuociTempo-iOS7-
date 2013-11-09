//
//  Peso.h
//  CuociTempo
//
//  Created by Michele Navolio on 09/11/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tempo;

@interface Peso : NSManagedObject

@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSNumber * pesoid;
@property (nonatomic, retain) NSSet *tempos;
@end

@interface Peso (CoreDataGeneratedAccessors)

- (void)addTemposObject:(Tempo *)value;
- (void)removeTemposObject:(Tempo *)value;
- (void)addTempos:(NSSet *)values;
- (void)removeTempos:(NSSet *)values;

@end
