//
//  HRFView.h
//  HRFun
//
//  Created by Craig Bennett on 6/30/08.
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

#import <Cocoa/Cocoa.h>
@class HRF;

@interface HRFView : NSView 
{
    // This instance of the HRF class is for calculating and storing HRF values
    HRF* response;
        
    // This array is for the temporary holding of HRF data points.
    NSMutableArray* responseArray;
        
    // Globals useful for turning the view into a graph
    float rangeX;
    float rangeY;
    float scaleX;
    float scaleY;
    
    // Checkboxes to enable or disable features
    IBOutlet NSButton* linesEnable;
    IBOutlet NSButton* responseEnable;
    IBOutlet NSButton* undershootEnable;
    IBOutlet NSButton* hrfEnable;
        
    // textFields to display data point values on mouseover
    IBOutlet NSTextField* timeCoord;
    IBOutlet NSTextField* hrfCoord;
    IBOutlet NSTextField* responseCoord;
    IBOutlet NSTextField* undershootCoord;
        
    // textFields to display and edit parameter values
    IBOutlet NSTextField* tr;
    IBOutlet NSTextField* kernelLength;
    IBOutlet NSTextField* onsetTime;
    IBOutlet NSTextField* responseDelay;
    IBOutlet NSTextField* responseDispersion;
    IBOutlet NSTextField* undershootDelay;
    IBOutlet NSTextField* undershootDispersion;
    IBOutlet NSTextField* ratio;
        
    // Stepper arrows to increment and decrement parameter values by a preset amount
    IBOutlet NSStepper* trStepperOutlet;
    IBOutlet NSStepper* kernelLengthStepperOutlet;
    IBOutlet NSStepper* onsetTimeStepperOutlet;
    IBOutlet NSStepper* responseDelayStepperOutlet;
    IBOutlet NSStepper* responseDispersionStepperOutlet;
    IBOutlet NSStepper* undershootDelayStepperOutlet;
    IBOutlet NSStepper* undershootDispersionStepperOutlet;
    IBOutlet NSStepper* ratioStepperOutlet;	
}

// Actions for checkbox changes
- (IBAction)linesEnableStatus:(id)sender;
- (IBAction)responseEnableStatus:(id)sender;
- (IBAction)undershootEnableStatus:(id)sender;
- (IBAction)hrfEnableStatus:(id)sender;

// Actions for stepper clicks
- (IBAction)trStepper:(id)sender;
- (IBAction)kernelLengthStepper:(id)sender;
- (IBAction)onsetTimeStepper:(id)sender;
- (IBAction)responseDelayStepper:(id)sender;
- (IBAction)responseDispersionStepper:(id)sender;
- (IBAction)undershootDelayStepper:(id)sender;
- (IBAction)undershootDispersionStepper:(id)sender;
- (IBAction)ratioStepper:(id)sender;

// Actions for parameter text changes
- (IBAction)trChanged:(id)sender;
- (IBAction)kernelChanged:(id)sender;
- (IBAction)onsetChanged:(id)sender;
- (IBAction)responseDelayChanged:(id)sender;
- (IBAction)responseDispersionChanged:(id)sender;
- (IBAction)undershootDelayChanged:(id)sender;
- (IBAction)undershootDispersionChanged:(id)sender;
- (IBAction)ratioChanged:(id)sender;

// Parameter value reset and update functions
- (IBAction)resetValues:(id)sender;
- (void) updateValues;


@end
