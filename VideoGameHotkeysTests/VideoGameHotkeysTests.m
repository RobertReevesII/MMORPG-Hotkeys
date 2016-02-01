//
//  VideoGameHotkeysTests.m
//  VideoGameHotkeysTests
//
//  Created by Robert Reeves II on 12/16/15.
//  Copyright © 2015 Robert Reeves II. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RLRDataController.h"

@interface VideoGameHotkeysTests : XCTestCase

@property RLRDataController *dataController;

@end

@implementation VideoGameHotkeysTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.dataController = [[RLRDataController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
        // Put the code you want to measure the time of here.
}

@end
