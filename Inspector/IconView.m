/* IconView.m
 *  
 * Copyright (C) 2005 Free Software Foundation, Inc.
 *
 * Author: Enrico Sersale <enrico@imago.ro>
 * Date: August 2005
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
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02111 USA.
 */

#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>
#include "IconView.h"
#include "Inspector.h"

@implementation IconView

- (void)setInspector:(id)insp
{
  inspector = insp;
  [self registerForDraggedTypes: [NSImage imagePasteboardTypes]]; 
}

- (void)setDndTarget:(BOOL)value
{
  dndTarget = value;
}

@end


@implementation IconView (NSDraggingDestination)

- (unsigned int)draggingEntered:(id <NSDraggingInfo>)sender
{
  return [inspector draggingEntered: sender inIconView: self];
}

- (unsigned int)draggingUpdated:(id <NSDraggingInfo>)sender
{
  return dndTarget;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
  [inspector draggingExited: sender inIconView: self];
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
  return dndTarget;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
  return dndTarget;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
  [inspector concludeDragOperation: sender inIconView: self];
}

- (unsigned int)draggingSourceOperationMaskForLocal:(BOOL)isLocal
{
  return NSDragOperationAll;
}

@end
