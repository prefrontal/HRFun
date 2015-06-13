//
//  HRF.m
//  HRFun
//
//  Created by Craig Bennett on 7/1/08.
//  Copyright 2008 prefrontal.org. All rights reserved.
//
//  --------------------------------------------------------------
//  
//  This file is part of HRFun.
//  
//  HRFun is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//  
//  HRFun is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//  
//  You should have received a copy of the GNU General Public License
//  along with HRFun (HRFun_license.txt); if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//  
//  --------------------------------------------------------------

#import "HRF.h"

@implementation HRF

// Setup accessors
@synthesize tr;
@synthesize onset;
@synthesize kernelLength;
@synthesize responseDelay;
@synthesize responseDispersion;
@synthesize undershootDelay;
@synthesize undershootDispersion;
@synthesize responseUndershootRatio;

- (id)init
{
    self = [super init];
    
    // initialize parameters to default values
    [self setTr: [NSNumber numberWithFloat:2.0]];
    [self setOnset: [NSNumber numberWithFloat:0.0]];
    [self setKernelLength: [NSNumber numberWithFloat:32.0]];
    [self setResponseDelay: [NSNumber numberWithFloat:6.0]];
    [self setResponseDispersion: [NSNumber numberWithFloat:1.0]];
    [self setUndershootDelay: [NSNumber numberWithFloat:16.0]];
    [self setUndershootDispersion: [NSNumber numberWithFloat:1.0]];
    [self setResponseUndershootRatio: [NSNumber numberWithFloat:6.0]];
    
    return self;
}


- (NSMutableArray*) calculateHRF;
{
    // This function takes the set of parameters and uses two gamma functions to calculate a hemodynamic response
    
    NSMutableArray* hemodynamicResponse = [[NSMutableArray alloc] init];    // Array to store data dictionary objects
    
    int numPoints = ([self.kernelLength floatValue] / [self.tr floatValue]);    // Determine number of data points based on kernel length and tr value
    
    for (int count = 0; count < numPoints; count++)
    {
        NSMutableDictionary* timePoint = [[NSMutableDictionary alloc] init];    // initialize a new data point
        
        float testValue = count * [self.tr floatValue] - [self.onset floatValue];    // determin value to evaluate function at
        
        float responseOutput = 0;
        float undershootOutput = 0;
        
        if (testValue > 0 )    // calculate the value of each gamma function at the test value
        {
            responseOutput = [self gammaPDF:testValue shapeParam:([self.responseDelay floatValue] / [self.responseDispersion floatValue]) scaleParam:([self.responseDispersion floatValue])];
            undershootOutput = [self gammaPDF:testValue shapeParam:([self.undershootDelay floatValue] / [self.undershootDispersion floatValue]) scaleParam:([self.undershootDispersion floatValue])] / [self.responseUndershootRatio floatValue];
        }

        // Place the resulting values in the data point dictionary
        [timePoint setValue:[NSNumber numberWithFloat:(testValue + [self.onset floatValue])] forKey:@"time"];
        [timePoint setValue:[NSNumber numberWithFloat:responseOutput] forKey:@"response"];
        [timePoint setValue:[NSNumber numberWithFloat:undershootOutput] forKey:@"undershoot"];
        [timePoint setValue:[NSNumber numberWithFloat:(responseOutput - undershootOutput)] forKey:@"HRF"];
        
        [hemodynamicResponse addObject:timePoint];
        [timePoint release];
    }

    [hemodynamicResponse autorelease];
    return hemodynamicResponse;
}


- (float)gammaPDF:(float)gammaVariate shapeParam:(float)shapeParam scaleParam:(float)scaleParam;
{
    // Only defined for positive values of shapeParam and scaleParam
    if (shapeParam <= 0)
    {
        // error code not implemented yet.  Limits instead placed on parameter input stage.
    }
    
    if (scaleParam <= 0)
    {
        // error code not implemented yet.  Limits instead placed on parameter input stage.
    }
    
    // Handling of degenerate cases
    if (gammaVariate == 0 & shapeParam < 1)
        return 100000;    // Should be Inf, but I am not sure how to implement that in Objective-C, C, or C++.
    
    if (gammaVariate == 0 & shapeParam == 1)
        return 1;
    
    if (gammaVariate == 0 & shapeParam > 1)
        return 0;
    
    // Calculate final gamma value.
    float finalValue = ((pow(scaleParam,shapeParam) * pow(gammaVariate,(shapeParam-1)) * exp(-1 * scaleParam * gammaVariate))) / gamma(shapeParam);
    
    return finalValue;
}

@end
