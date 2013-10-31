//
//  CuociTempoTests.m
//  CuociTempoTests
//
//  Created by Michele Navolio on 07/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Alimento.h"

@interface CuociTempoTests : XCTestCase

@end

@implementation CuociTempoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    // MOM
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CuociTempo" withExtension:@"momd"];
    NSManagedObjectModel* mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    // Store Coordinator
    if (!mom) {
        XCTAssertTrue(NO, @"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return;
    }
    
    NSError *error = nil;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"CuociTempo" withExtension:@"sqlite"];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]) {
        XCTAssertTrue(NO, @"Error adding persistence store: %@",[error localizedDescription]);
        return;
    }
    
    // Context
    NSManagedObjectContext* moc = [[NSManagedObjectContext alloc] init];
    [moc setPersistentStoreCoordinator:coordinator];
    
    // Insert new album
   // Alimento* newAlbum = (Alimento*)[NSEntityDescription insertNewObjectForEntityForName:@"Alimento" inManagedObjectContext:moc];

    // fetch artist
    NSFetchRequest* fetchReq = [[NSFetchRequest alloc] initWithEntityName:@"Alimento"];
    //[fetchReq setPredicate:[NSPredicate predicateWithFormat:@"artistid = 1"]];
    error = nil;
    NSArray* artists = [moc executeFetchRequest:fetchReq error:&error];
    for (Alimento *a in artists) {
        NSLog(@"Title %@",a.name );
    }
    if (error) {
        XCTAssertTrue(NO, @"Error fetching record: %@",[error localizedDescription]);
        return;
    }

}

@end
