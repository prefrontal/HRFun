//
//  HRF.h
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

#import <Cocoa/Cocoa.h>

@interface HRF : NSObject 
{
    // Variables for parameter storage
    NSNumber* tr;
    NSNumber* onset;
    NSNumber* kernelLength;
    NSNumber* responseDelay;
    NSNumber* responseDispersion;
    NSNumber* undershootDelay;
    NSNumber* undershootDispersion;
    NSNumber* responseUndershootRatio;
}

// Setup the accessors
@property (retain) NSNumber* tr;
@property (retain) NSNumber* onset;
@property (retain) NSNumber* kernelLength;
@property (retain) NSNumber* responseDelay;
@property (retain) NSNumber* responseDispersion;
@property (retain) NSNumber* undershootDelay;
@property (retain) NSNumber* undershootDispersion;
@property (retain) NSNumber* responseUndershootRatio;

- (NSMutableArray*) calculateHRF;

- (float)gammaPDF:(float)gammaVariate shapeParam:(float)shapeParam scaleParam:(float)scaleParam;

@end
