/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "AssetsList.h"
#import "Asset.h"

@implementation AssetsList

-(id)initWithALAssetsArray:(NSArray*)alAssets
{
    self = [super init];
    if (self)
    {
        assets = [alAssets retain];
    }
    
}

-(void)dealloc
{
    RELEASE_TO_NIL(assets);
    [super dealloc];
}

-(NSNumber*)assetsCount
{
    return [NSNumber numberWithInt:[assets count]];
}

-(Asset*)getAssetAtIndex:(id)args
{
    ENSURE_SINGLE_ARG(args, NSNumber);
    return [[[Asset alloc] initWithAsset:[assets objectAtIndex:[args intValue]]] autorelease];
}

@end
