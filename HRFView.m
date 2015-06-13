//
//  HRFView.m
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

#import "HRFView.h"
#import "HRF.h"

@implementation HRFView

#pragma mark init

- (id)initWithFrame:(NSRect)frame 
{
    self = [super initWithFrame:frame];
        
    if (self) 
    {
        // Could put some init code here if desired
    }
        
    return self;
}

- (void)awakeFromNib
{
    // Initialize the response and responseArray objects
    response = [[HRF alloc] init];
    responseArray = [[NSMutableArray alloc] init];
    
    // Set the font of the graph popup values to Courier so that they line up with each other
    NSFont* font = [NSFont fontWithName:@"Courier" size:10.0];
    [timeCoord setFont:font];
    [hrfCoord setFont:font];
    [responseCoord setFont:font];
    [undershootCoord setFont:font];

    // Make the view first responder and set the values of the parameter text fields
    [[self window] makeFirstResponder:self];
    [self updateValues];
    
}

- (BOOL)acceptsFirstResponder
{
	return YES;
}

#pragma mark IBActions

// The following actions simply call for a refresh of the view after their value changes.  The drawRect code handles the logic.

- (IBAction)linesEnableStatus:(id)sender;
{
	[self setNeedsDisplay:YES];
}

- (IBAction)responseEnableStatus:(id)sender;
{
	[self setNeedsDisplay:YES];
}

- (IBAction)undershootEnableStatus:(id)sender;
{
	[self setNeedsDisplay:YES];
}

- (IBAction)hrfEnableStatus:(id)sender;
{
	[self setNeedsDisplay:YES];
}

// The following actions are related the the parameter steppers.  When the user clicks on a stepper direction the text field value is updated and a value refresh is called for.

- (IBAction)trStepper:(id)sender;
{
	[response setTr:[NSNumber numberWithFloat:[sender floatValue]]];
	[self updateValues];
}

- (IBAction)kernelLengthStepper:(id)sender;
{
	[response setKernelLength:[NSNumber numberWithFloat:[sender floatValue]]];
	[self updateValues];
}

- (IBAction)onsetTimeStepper:(id)sender;
{
	[response setOnset:[NSNumber numberWithFloat:[sender floatValue]]];
	[self updateValues];
}

- (IBAction)responseDelayStepper:(id)sender;
{
	[response setResponseDelay:[NSNumber numberWithFloat:[sender floatValue]]];
	[self updateValues];
}

- (IBAction)responseDispersionStepper:(id)sender;
{
	[response setResponseDispersion:[NSNumber numberWithFloat:[sender floatValue]]];
	[self updateValues];
}

- (IBAction)undershootDelayStepper:(id)sender;
{
	[response setUndershootDelay:[NSNumber numberWithFloat:[sender floatValue]]];
	[self updateValues];
}

- (IBAction)undershootDispersionStepper:(id)sender;
{
	[response setUndershootDispersion:[NSNumber numberWithFloat:[sender floatValue]]];
	[self updateValues];	
}

- (IBAction)ratioStepper:(id)sender;
{
	[response setResponseUndershootRatio:[NSNumber numberWithFloat:[sender floatValue]]];
	[self updateValues];	
}

// The following actions handle user entered text field values.  When a value is changed the value in the HRF object is updated, the stepper value is reset to the new value, and a value refresh is called.

- (IBAction)trChanged:(id)sender;
{
	[response setTr:[NSNumber numberWithFloat:[sender floatValue]]];
	[trStepperOutlet setFloatValue:[response.tr floatValue]];
	[self updateValues];
}

- (IBAction)kernelChanged:(id)sender;
{
	[response setKernelLength:[NSNumber numberWithFloat:[sender floatValue]]];
	[kernelLengthStepperOutlet setFloatValue:[response.kernelLength floatValue]];
	[self updateValues];
}

- (IBAction)onsetChanged:(id)sender;
{
	[response setOnset:[NSNumber numberWithFloat:[sender floatValue]]];
	[onsetTimeStepperOutlet setFloatValue:[response.onset floatValue]];
	[self updateValues];
}

- (IBAction)responseDelayChanged:(id)sender;
{
	[response setResponseDelay:[NSNumber numberWithFloat:[sender floatValue]]];
	[responseDelayStepperOutlet setFloatValue:[response.responseDelay floatValue]];
	[self updateValues];
}

- (IBAction)responseDispersionChanged:(id)sender;
{
	[response setResponseDispersion:[NSNumber numberWithFloat:[sender floatValue]]];
	[responseDispersionStepperOutlet setFloatValue:[response.responseDispersion floatValue]];
	[self updateValues];
}

- (IBAction)undershootDelayChanged:(id)sender;
{
	[response setUndershootDelay:[NSNumber numberWithFloat:[sender floatValue]]];
	[undershootDelayStepperOutlet setFloatValue:[response.undershootDelay floatValue]];
	[self updateValues];
}

- (IBAction)undershootDispersionChanged:(id)sender;
{
	[response setUndershootDispersion:[NSNumber numberWithFloat:[sender floatValue]]];
	[undershootDispersionStepperOutlet setFloatValue:[response.undershootDispersion floatValue]];
	[self updateValues];
}

- (IBAction)ratioChanged:(id)sender;
{
	[response setResponseUndershootRatio:[NSNumber numberWithFloat:[sender floatValue]]];
	[ratioStepperOutlet setFloatValue:[response.responseUndershootRatio floatValue]];
	[self updateValues];
}

// The updateValues function is the primary means of sync'ing the text fields with the values in the HRF object

- (void) updateValues;
{
    [tr setFloatValue:[response.tr floatValue]];
    [kernelLength setFloatValue:[response.kernelLength floatValue]];
    [onsetTime setFloatValue:[response.onset floatValue]];
    [responseDelay setFloatValue:[response.responseDelay floatValue]];
    [responseDispersion setFloatValue:[response.responseDispersion floatValue]];
    [undershootDelay setFloatValue:[response.undershootDelay floatValue]];
    [undershootDispersion setFloatValue:[response.undershootDispersion floatValue]];
    [ratio setFloatValue:[response.responseUndershootRatio floatValue]];
        
    [trStepperOutlet setFloatValue:[response.tr floatValue]];
    [kernelLengthStepperOutlet setFloatValue:[response.kernelLength floatValue]];
    [onsetTimeStepperOutlet setFloatValue:[response.onset floatValue]];
    [responseDelayStepperOutlet setFloatValue:[response.responseDelay floatValue]];
    [responseDispersionStepperOutlet setFloatValue:[response.responseDispersion floatValue]];
    [undershootDelayStepperOutlet setFloatValue:[response.undershootDelay floatValue]];
    [undershootDispersionStepperOutlet setFloatValue:[response.undershootDispersion floatValue]];
    [ratioStepperOutlet setFloatValue:[response.responseUndershootRatio floatValue]];
        
    [self setNeedsDisplay:YES];
}

// resetValues is called from the menu and resets all parameter values to their initial state.

- (IBAction)resetValues:(id)sender;
{
    response.tr = [NSNumber numberWithFloat:2.0];
    response.kernelLength = [NSNumber numberWithFloat:32];
    response.onset = [NSNumber numberWithFloat:0];
    response.responseDelay = [NSNumber numberWithFloat:6];
    response.responseDispersion = [NSNumber numberWithFloat:1];
    response.undershootDelay = [NSNumber numberWithFloat:16];
    response.undershootDispersion = [NSNumber numberWithFloat:1];
    response.responseUndershootRatio = [NSNumber numberWithFloat:6];
    
    [self updateValues];
}


#pragma mark Mouse Code

- (void)mouseMoved:(NSEvent *)event
{
	// This function determines the closest data point to the mouse and then displays the values of that data point in a piece of popup text.
	
	NSPoint eventLocation = [event locationInWindow];
	NSPoint center = [self convertPoint:eventLocation fromView:nil];
	
	int dictID;
	float distance;
	responseArray = [response calculateHRF];	// Get the array of all HRF data point objects.
	
	for (NSMutableDictionary* dictObject in responseArray)    // Search over all data objects for the one closet to the mouse X value.
    {
        if ([responseArray indexOfObject:dictObject] == 0)    // Special case if it is the first object in the array.  Make it the new best case since there is only one case.
        {
            distance = fabs(([[dictObject valueForKey:@"time"] floatValue] * scaleX + 50) - center.x);
            continue;
        }

        if (fabs(([[dictObject valueForKey:@"time"] floatValue]* scaleX + 50) - center.x) < distance)    // Compare previous best case to new candidate object.  Update values if better.
        {
            dictID = [responseArray indexOfObject:dictObject];
            distance = fabs(([[dictObject valueForKey:@"time"] floatValue] * scaleX + 50) - center.x);
        }
        
    }
	
	NSMutableDictionary* closeObject = [responseArray objectAtIndex:dictID];    // Get the object that was closest to the mouse X value
	
	// Display the relevant data values of the closest data point in the popup text fields.  There is some logic for each function that keeps the width of the text constant (pretty).
	
	[timeCoord setTextColor:[NSColor grayColor]];
	[timeCoord setStringValue: [NSString stringWithFormat:@"Time: %2.2f",([[closeObject valueForKey:@"time"] floatValue])]];
	
	if ([responseEnable state] == 1)  // Display the values for the response gamma, if enabled
    {
        [responseCoord setTextColor:[NSColor grayColor]];

        if ([[closeObject valueForKey:@"response"] floatValue] > 0)
            [responseCoord setStringValue: [NSString stringWithFormat:@"Res:  %0.3f",([[closeObject valueForKey:@"response"] floatValue])]];
        else
            [responseCoord setStringValue: [NSString stringWithFormat:@"Res: %0.3f",([[closeObject valueForKey:@"response"] floatValue])]];
    }
	else
    {
        [responseCoord setTextColor:[NSColor whiteColor]];
    }
	
	if ([undershootEnable state] == 1)    // Display the values for the undershoot gamma, if enabled
    {
        [undershootCoord setTextColor:[NSColor grayColor]];

        if ([[closeObject valueForKey:@"undershoot"] floatValue] > 0)
            [undershootCoord setStringValue: [NSString stringWithFormat:@"Und: %0.3f",(-1 * [[closeObject valueForKey:@"undershoot"] floatValue])]];
        else
            [undershootCoord setStringValue: [NSString stringWithFormat:@"Und:%0.3f",(-1 * [[closeObject valueForKey:@"undershoot"] floatValue])]];
    }
	else
    {
        [undershootCoord setTextColor:[NSColor whiteColor]];
    }
	
	if ([hrfEnable state] == 1)    // Display the values for the hemodynamic response, if enabled
    {
        [hrfCoord setTextColor:[NSColor grayColor]];
        
        if ([[closeObject valueForKey:@"HRF"] floatValue] > 0)
            [hrfCoord setStringValue: [NSString stringWithFormat:@"HRF:  %0.3f",([[closeObject valueForKey:@"HRF"] floatValue])]];
        else
            [hrfCoord setStringValue: [NSString stringWithFormat:@"HRF: %0.3f",([[closeObject valueForKey:@"HRF"] floatValue])]];
    }
	else
    {
        [hrfCoord setTextColor:[NSColor whiteColor]];
    }
}


- (void)mouseExited:(NSEvent *)theEvent
{
    // When the mouse leaves the view make the color of the popup text white to make it invisible
    
    [timeCoord setTextColor:[NSColor whiteColor]];
    [hrfCoord setTextColor:[NSColor whiteColor]];
    [responseCoord setTextColor:[NSColor whiteColor]];
    [undershootCoord setTextColor:[NSColor whiteColor]];
}

#pragma mark Drawing Code

- (void)drawRect:(NSRect)rect 
{
    // Fill the background of the view with white
    NSRect bounds = [self bounds];
    [[NSColor whiteColor] set];
    [NSBezierPath fillRect:bounds];
    
    // Setup the mouse tracking area.  Remove previous tracking areas if present.  This may not be the best strategy, but it works.
    NSArray* test = [self trackingAreas];
    for (NSTrackingArea* element in test)
        [self removeTrackingArea:element];
    
    NSTrackingArea* trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow ) owner:self userInfo:nil];
    [self addTrackingArea:trackingArea];
    
    // Get the current array of HRF data points
    responseArray = [response calculateHRF];
    
    // Determine the maximum and minimum values of the HRF for the X and Y axes.  This will be critical for graphing.  Assume that X starts at zero.
    
    float maximumX = 0;
    float maximumY = 0;
    float minimumX = 0;
    float minimumY = 0;
    
    maximumX = [response.kernelLength floatValue];
    
    for (NSMutableDictionary* dictObject in responseArray)
    {
        if ([[dictObject valueForKey:@"response"] floatValue] > maximumY)
            maximumY = [[dictObject valueForKey:@"response"] floatValue];
        
        if ([[dictObject valueForKey:@"response"] floatValue] < minimumY)
            minimumY = [[dictObject valueForKey:@"response"] floatValue];
        
        if (-1 * [[dictObject valueForKey:@"undershoot"] floatValue] > maximumY)
            maximumY = -1 * [[dictObject valueForKey:@"undershoot"] floatValue];
        
        if (-1 * [[dictObject valueForKey:@"undershoot"] floatValue] < minimumY)
            minimumY = -1 * [[dictObject valueForKey:@"undershoot"] floatValue];
        
        if ([[dictObject valueForKey:@"HRF"] floatValue] > maximumY)
            maximumY = [[dictObject valueForKey:@"HRF"] floatValue];
        
        if ([[dictObject valueForKey:@"HRF"] floatValue] < minimumY)
            minimumY = [[dictObject valueForKey:@"HRF"] floatValue];
    }

    // Determine range of each axis and the scale factor to map HRF values onto the view
    rangeX = (maximumX - minimumX);
    rangeY = (maximumY - minimumY);
    scaleX = ((bounds.size.width-50)/rangeX);
    scaleY = ((bounds.size.height-50)/rangeY);

    // Draw the axes
    
    [[NSColor grayColor] set];
    
    NSPoint top = NSMakePoint(50,bounds.size.height);
    NSPoint bottom = NSMakePoint(50,0);
    NSPoint left = NSMakePoint(0,(-1 * minimumY * scaleY)+25);
    NSPoint right = NSMakePoint(bounds.size.width,(-1 * minimumY * scaleY)+25);

    [NSBezierPath strokeRect:bounds];
    [NSBezierPath strokeLineFromPoint:top toPoint:bottom];
    [NSBezierPath strokeLineFromPoint:left toPoint:right];
    
    // Draw the tics and labels for the X axis.
    
    [[NSColor colorWithCalibratedWhite:.2 alpha:.5] set];
    
    float j;
    
    for (j = 1; j <= maximumX; j++)    // Draw X tics every second
    {
        NSPoint high = NSMakePoint(j * scaleX + 50,(-1 * minimumY * scaleY)+30);
        NSPoint low = NSMakePoint(j * scaleX + 50,(-1 * minimumY * scaleY)+20);
        [NSBezierPath strokeLineFromPoint:high toPoint:low];
    }
    
    for (j = 5; j <= maximumX; j = j + 5)    // Draw X labels every 5 seconds
    {
        NSString* LabelX = [[NSString alloc] initWithFormat:@"%2.0f", j];
        NSSize stringSize = [LabelX sizeWithAttributes:NULL];
            
        [LabelX drawAtPoint:NSMakePoint(((j) * scaleX + 50 - .5 * stringSize.width),(-1 * minimumY * scaleY)+7) withAttributes:NULL];
        [LabelX release];
    }
            
    // Draw the tics and labels for the Y axis.
    
    [[NSColor colorWithCalibratedWhite:.2 alpha:.5] set];
    
    for (j = .01; j <= maximumY + .01; (j = j + 0.01))    //  Draw positive Y tics every 0.01
    {
        NSPoint left = NSMakePoint(45,(-1 * minimumY * scaleY)+25 + j * scaleY);
        NSPoint right = NSMakePoint(55,(-1 * minimumY * scaleY)+25 + j * scaleY);
        [NSBezierPath strokeLineFromPoint:left toPoint:right];
    }
    
    for (j = .05; j <= maximumY + .01; (j = j + 0.05))    // Draw positive Y labels every 0.05
    {
        NSString* LabelY = [[NSString alloc] initWithFormat:@"%0.2f", j];
        NSSize stringSize = [LabelY sizeWithAttributes:NULL];
        [LabelY drawAtPoint:NSMakePoint(18,(-1 * minimumY * scaleY)+ 26 - .5 * stringSize.height + j * scaleY) withAttributes:NULL];
        [LabelY release];
    }
    
    [[NSColor colorWithCalibratedWhite:.2 alpha:.5] set];
    
    for (j = -.01; j >= minimumY - .01; (j = j - 0.01))    // Draw negative Y tics every 0.01
    {
        NSPoint left = NSMakePoint(45,(-1 * minimumY * scaleY)+25 + j * scaleY);
        NSPoint right = NSMakePoint(55,(-1 * minimumY * scaleY)+25 + j * scaleY);
        [NSBezierPath strokeLineFromPoint:left toPoint:right];
    }
    
    for (j = -.05; j >= minimumY - .01; (j = j - 0.05))    // Draw negative Y labels every 0.05
    {
        NSString* LabelY = [[NSString alloc] initWithFormat:@"%0.2f", j];
        NSSize stringSize = [LabelY sizeWithAttributes:NULL];
        [LabelY drawAtPoint:NSMakePoint(18,(-1 * minimumY * scaleY)+ 26 - .5 * stringSize.height + j * scaleY) withAttributes:NULL];
        [LabelY release];
    }

    // Draw the graphs - oh yeah.
    
    NSPoint previousPoint = NSMakePoint(0,0);
    NSPoint thisPoint = NSMakePoint(0,0);
    
    if ([responseEnable state] == 1)  // Draw the response gamma, if enabled
    {
        [[NSColor redColor] set];
            
        for (NSMutableDictionary* dictObject in responseArray)
        {
            if ( [[dictObject valueForKey:@"time"] floatValue] < 0)    // Don't draw timepoint 0
                continue;
            
            thisPoint = NSMakePoint([[dictObject valueForKey:@"time"] floatValue] * scaleX + 50,([[dictObject valueForKey:@"response"] floatValue] - minimumY) * scaleY + 25);
            
            if ([linesEnable state] == 0)    // Draw dots if lines is disabled
            {
                NSRect aRect = NSMakeRect(thisPoint.x, thisPoint.y, 3.0, 3.0);
                NSRectFill(aRect);
            }
            
            if ([linesEnable state] == 1)    // Draw lines if enabled
            {
                if ([responseArray indexOfObject:dictObject] == 0)
                {
                    previousPoint = NSMakePoint([[dictObject valueForKey:@"time"] floatValue] * scaleX + 50,([[dictObject valueForKey:@"response"] floatValue] - minimumY) * scaleY + 25);
                    continue;
                }
                
                [NSBezierPath strokeLineFromPoint:thisPoint toPoint:previousPoint];
                
                previousPoint = thisPoint;
            }
        }
    }
            
    if ([undershootEnable state] == 1)    // Draw undershoot if enabled
    {
        [[NSColor blueColor] set];
        
        for (NSMutableDictionary* dictObject in responseArray)
        {
            if ( [[dictObject valueForKey:@"time"] floatValue] < 0)     // Don't draw timepoint 0
                continue;
            
            NSPoint thisPoint = NSMakePoint([[dictObject valueForKey:@"time"] floatValue] * scaleX + 50,(-1 * [[dictObject valueForKey:@"undershoot"] floatValue] - minimumY) * scaleY + 25);
            
            if ([linesEnable state] == 0)    // Draw dots if lines is disabled
            {
                NSRect aRect = NSMakeRect(thisPoint.x, thisPoint.y, 3.0, 3.0);
                NSRectFill(aRect);
            }
            
            if ([linesEnable state] == 1)    // Draw lines if enabled
            {
                if ([responseArray indexOfObject:dictObject] == 0)
                {
                    previousPoint = NSMakePoint([[dictObject valueForKey:@"time"] floatValue] * scaleX + 50,(-1 * [[dictObject valueForKey:@"undershoot"] floatValue] - minimumY) * scaleY + 25);
                    continue;
                }
                
                [NSBezierPath strokeLineFromPoint:thisPoint toPoint:previousPoint];
                
                previousPoint = thisPoint;
            }
        }
    }
    
    if ([hrfEnable state] == 1)    // Draw the HRF, if enabled
    {
        [[NSColor greenColor] set];

        for (NSMutableDictionary* dictObject in responseArray)
        {
            if ( [[dictObject valueForKey:@"time"] floatValue] < 0)     // Don't draw timepoint 0
                continue;

            NSPoint thisPoint = NSMakePoint([[dictObject valueForKey:@"time"] floatValue] * scaleX + 50,([[dictObject valueForKey:@"HRF"] floatValue] - minimumY) * scaleY + 25);
            
            if ([linesEnable state] == 0)    // Draw dots if lines is disabled
            {
                NSRect aRect = NSMakeRect(thisPoint.x, thisPoint.y, 3.0, 3.0);
                NSRectFill(aRect);
            }
            
            if ([linesEnable state] == 1)    // Draw lines if enabled
            {
                if ([responseArray indexOfObject:dictObject] == 0)
                {
                    previousPoint = NSMakePoint([[dictObject valueForKey:@"time"] floatValue] * scaleX + 50,([[dictObject valueForKey:@"HRF"] floatValue] - minimumY) * scaleY + 25);
                    continue;
                }
                
                [NSBezierPath strokeLineFromPoint:thisPoint toPoint:previousPoint];
                
                previousPoint = thisPoint;
            }
        }
    }
    
}

@end
