/* GWDesktopIcon.m
 *  
 * Copyright (C) 2005 Free Software Foundation, Inc.
 *
 * Author: Enrico Sersale <enrico@imago.ro>
 * Date: January 2005
 *
 * This file is part of the GNUstep GWorkspace application
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */
 
#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>
#include "GWDesktopIcon.h"

@implementation GWDesktopIcon

- (void)mouseDown:(NSEvent *)theEvent
{
  NSPoint location = [theEvent locationInWindow];
  BOOL onself = NO;
	NSEvent *nextEvent = nil;
  BOOL startdnd = NO;

  location = [self convertPoint: location fromView: nil];

  if (icnPosition == NSImageOnly) {
    onself = [self mouse: location inRect: icnBounds];
  } else {
    onself = ([self mouse: location inRect: icnBounds]
                        || [self mouse: location inRect: labelRect]);
  }

  if (onself) {
    if (selectable == NO) {
      return;
    }

	  if ([theEvent clickCount] == 1) {
      if (isSelected == NO) {
        [container stopRepNameEditing];
        [container repSelected: self];
      }
      
		  if ([theEvent modifierFlags] & NSShiftKeyMask) {
        [container setSelectionMask: FSNMultipleSelectionMask];
         
			  if (isSelected) {
          if ([container selectionMask] == FSNMultipleSelectionMask) {
				    [self unselect];
            [container selectionDidChange];	
				    return;
          }
        } else {
				  [self select];
			  }
        
		  } else {
        [container setSelectionMask: NSSingleSelectionMask];
        
        if (isSelected == NO) {
				  [self select];
			  }
		  }
    
      if (dndSource) {
        while (1) {
	        nextEvent = [[self window] nextEventMatchingMask:
    							                  NSLeftMouseUpMask | NSLeftMouseDraggedMask];

          if ([nextEvent type] == NSLeftMouseUp) {
            [[self window] postEvent: nextEvent atStart: NO];
            break;

          } else if ([nextEvent type] == NSLeftMouseDragged) {
	          if (dragdelay < 5) {
              dragdelay++;
            } else {     
              startdnd = YES;        
              break;
            }
          }
        }
      }
      
      if (startdnd == YES) {  
        [container stopRepNameEditing];
        [self startExternalDragOnEvent: nextEvent];    
      }
      
      editstamp = [theEvent timestamp];       
	  } 
    
  } else {
    [container mouseDown: theEvent];
  }
}

@end