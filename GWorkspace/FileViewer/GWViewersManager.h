/* GWViewersManager.h
 *  
 * Copyright (C) 2004 Free Software Foundation, Inc.
 *
 * Author: Enrico Sersale <enrico@imago.ro>
 * Date: June 2004
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

#ifndef GWVIEWERS_MANAGER_H
#define GWVIEWERS_MANAGER_H

#include <Foundation/Foundation.h>
#include "FSNodeRep.h"

#define BROWSING 0
#define SPATIAL  1

@class GWorkspace;

@interface GWViewersManager : NSObject
{
  NSMutableArray *viewers;
  BOOL orderingViewers;
  GWorkspace *gworkspace;
  NSNotificationCenter *nc;    
}

+ (GWViewersManager *)viewersManager;


- (id)newViewerOfType:(unsigned)vtype
              forNode:(FSNode *)node
       closeOldViewer:(id)oldvwr;
       
- (void)setBehaviour:(NSString *)behaviour 
           forViewer:(id)aviewer;
           
- (NSArray *)viewersForBaseNode:(FSNode *)node;

- (id)viewerOfType:(unsigned)type
      withBaseNode:(FSNode *)node; 

- (id)viewerOfType:(unsigned)type
       showingNode:(FSNode *)node; 

- (id)parentOfSpatialViewer:(id)aviewer;


- (void)viewerWillClose:(id)aviewer;

- (void)closeInvalidViewers:(NSArray *)vwrs;


- (void)selectedSpatialViewerChanged:(id)aviewer;

- (void)synchronizeSelectionInParentOfViewer:(id)aviewer;

- (void)viewer:(id)aviewer didShowNode:(FSNode *)node;


- (void)selectionChanged:(NSArray *)selection;

- (void)openSelectionInViewer:(id)viewer
                  closeSender:(BOOL)close;
                  
- (void)openAsFolderSelectionInViewer:(id)viewer;


- (void)sortTypeDidChange:(NSNotification *)notif;

- (void)fileSystemWillChange:(NSNotification *)notif;

- (void)fileSystemDidChange:(NSNotification *)notif;

- (void)watcherNotification:(NSNotification *)notif;

- (void)thumbnailsDidChangeInPaths:(NSArray *)paths;


- (BOOL)hasViewerWithWindow:(id)awindow;

- (id)viewerWithWindow:(id)awindow;

@end

#endif // GWVIEWERS_MANAGER_H