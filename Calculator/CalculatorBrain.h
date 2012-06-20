//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Nai Chng on 11/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clearOperation; 
- (int)countOccurrenceOfString:(NSString *)display; 

@end
