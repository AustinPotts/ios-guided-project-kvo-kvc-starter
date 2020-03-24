//
//  ViewController.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIDepartment.h"
#import "LSIEmployee.h"
#import "LSIHRController.h"


@interface ViewController ()

@property (nonatomic) LSIHRController *hrController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    LSIDepartment *marketing = [[LSIDepartment alloc] init];
    marketing.name = @"Marketing";
    LSIEmployee * philSchiller = [[LSIEmployee alloc] init];
    philSchiller.name = @"Phil";
    philSchiller.jobTitle = @"VP of Marketing";
    philSchiller.salary = 10000000; 
    marketing.manager = philSchiller;

    
    LSIDepartment *engineering = [[LSIDepartment alloc] init];
    engineering.name = @"Engineering";
    LSIEmployee *craig = [[LSIEmployee alloc] init];
    craig.name = @"Craig";
    craig.salary = 9000000;
    craig.jobTitle = @"Head of Software";
    engineering.manager = craig;
    
    LSIEmployee *e1 = [[LSIEmployee alloc] init];
    e1.name = @"Chad";
    e1.jobTitle = @"Engineer";
    e1.salary = 200000;
    
    LSIEmployee *e2 = [[LSIEmployee alloc] init];
    e2.name = @"Lance";
    e2.jobTitle = @"Engineer";
    e2.salary = 250000;
    
    LSIEmployee *e3 = [[LSIEmployee alloc] init];
    e3.name = @"Joe";
    e3.jobTitle = @"Marketing Designer";
    e3.salary = 100000;
    
    [engineering addEmployee:e1];
    [engineering addEmployee:e2];
    [marketing addEmployee:e3];

    LSIHRController *controller = [[LSIHRController alloc] init];
    [controller addDepartment:engineering];
    [controller addDepartment:marketing];
    self.hrController = controller;
    
    NSLog(@"%@", self.hrController);
    
    
    
    // Key Value Coding: KVC
   
    //Property setter
    craig.name = @"Craig";
    [craig setName:@"Craig2"];
    
    //KVC
    [craig setValue:@"Bob" forKey:@"name"];
    NSLog(@"Name: %@", craig.name);
    
    [craig setValue:@"Bob" forKey:@"firstName"]; //CRASH: there is no first name property. The system will not know that we are wrong
    
    // Getting the value similar to setting the value 
    NSString *name = [craig valueForKey:@"name"];
    NSLog(@"Name: %@", name);
    
    
    NSString *privateName = [craig valueForKey:@"privateName"]; // Private Property Access
    NSLog(@"privateName: %@", privateName);
    
    NSString *privateVariable = [craig valueForKey:@"privateVariable"];
    NSLog(@"privateVariable: %@", privateVariable); // Private Variable Access
    
    // Private properties & variables are not 100% private
    
    
    // Key Path Values
    //[Departments]
    NSLog(@"Departments: %@", self.hrController.departments); // dot syntax
    NSLog(@"Departments: %@", [self.hrController valueForKeyPath:@"departments"]);
    
    //Traverse the object using string value
    //Swift [[Employee]]
    NSLog(@"Employees: %@", [self.hrController valueForKeyPath:@"departments.employees"]);
    
    
    //Collection Operators
    
    //Swift: [Employee]
    NSArray *employees = [self.hrController valueForKeyPath:@"departments.@distinctUnionOfArrays.employees"];
    NSLog(@"employees: %@", employees);
    
    NSLog(@"salaries: %@", [employees valueForKeyPath:@"salary"]);
    NSLog(@"max salaries: %@", [employees valueForKeyPath:@"@max.salary"]);
    NSLog(@"avg salaries: %@", [employees valueForKeyPath:@"@avg.salary"]);
    
    
    
}


@end
