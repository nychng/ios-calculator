//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Nai Chng on 11/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber; 
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, retain) NSMutableArray *decimalArray; 

@end

@implementation CalculatorViewController


@synthesize decimalArray;
@synthesize brain = _brain;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize display;
@synthesize history;

- (CalculatorBrain *)brain {
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

-(NSMutableArray *)decimalArray
{
    if(!decimalArray) {
        decimalArray = [[NSMutableArray alloc] init];
    }
    return decimalArray;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    if ([digit isEqualToString:@"."]) {
        [self.decimalArray addObject:digit];
    }    

    if (userIsInTheMiddleOfEnteringANumber) {
        if (!(self.decimalArray.count > 1 && [digit isEqualToString:@"."])) {
            self.display.text = [self.display.text stringByAppendingString:digit]; 
        }
    } else {
            self.display.text = digit;
        userIsInTheMiddleOfEnteringANumber = YES;
    }
    
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.history.text = [self.history.text stringByAppendingString: [NSString stringWithFormat:@"%@ ", self.display.text]];
    
    self.userIsInTheMiddleOfEnteringANumber = NO;
    if (self.decimalArray) [self.decimalArray removeAllObjects]; 
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
    self.history.text = [self.history.text stringByAppendingString:[NSString stringWithFormat:@"%@ " ,operation]];
}

- (IBAction)clearBtn:(UIButton *)sender {
    [self.brain clearOperation];
    self.display.text = @"0";
    self.history.text = @"";
    if (self.decimalArray) [self.decimalArray removeAllObjects];
    userIsInTheMiddleOfEnteringANumber = NO;
}

- (void)viewDidUnload {
    [self setHistory:nil];
    [super viewDidUnload];
}
@end