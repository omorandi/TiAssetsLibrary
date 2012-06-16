/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "AssetsGroup.h"
#import <AssetsLibrary/ALAssetsFilter.h>
#import "AssetsList.h"


@implementation AssetsGroup

-(id)initWithALAssetsGroup:(ALAssetsGroup*)group
{
    self = [super init];
    if (self)
    {
        assetsGroup = [group retain];
    }
    return self;
}



-(void)dealloc
{
    RELEASE_TO_NIL(assetsGroup);
    [super dealloc];
}

-(ALAssetsFilter*)assetsFilterForConstant:(NSString*)k
{
    if ([k isEqualToString:(NSString*)kAssetsFilterAll])
    {
        return [ALAssetsFilter allAssets];
    }
    else if ([k isEqualToString:(NSString*)kAssetsFilterPhotos])
    {
        return [ALAssetsFilter allPhotos];
    }
    else if ([k isEqualToString:(NSString*)kAssetsFilterVideos])
    {
        return [ALAssetsFilter allVideos];
    }
}


#pragma AssetsGroup public API

-(NSString*)name
{
    return [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
}

-(NSNumber*)type
{
    return [assetsGroup valueForProperty:ALAssetsGroupPropertyType];
}

-(NSString*)persistentID
{
    return [assetsGroup valueForProperty:ALAssetsGroupPropertyPersistentID];
}


-(NSString*)URL
{
    NSURL *url = [assetsGroup valueForProperty:ALAssetsGroupPropertyURL];
    return [url absoluteString];
}


-(NSNumber*)numberOfAssets
{
    return [NSNumber numberWithInt:[assetsGroup numberOfAssets]];
}


-(TiBlob*)posterImage
{
    UIImage *image = [UIImage imageWithCGImage:[assetsGroup posterImage]];
    return [[[TiBlob alloc] initWithImage:image] autorelease];
}


-(void)setAssetsFilter:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    currentAssetsFilter = args;
    [assetsGroup setAssetsFilter:[self assetsFilterForConstant:args]];
    
}

-(NSString*)assetsFilter
{
    return currentAssetsFilter;
}


-(void)getAssets:(id)callback
{
    ENSURE_SINGLE_ARG(callback, KrollCallback);
    
    NSMutableArray *assets = [[NSMutableArray alloc] init];
    [assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        [assets addObject:result];
        if ((*stop) == YES)
        {
            NSDictionary *obj = [NSDictionary dictionaryWithObject:assets forKey:@"assets"];
            [self _fireEventToListener:@"gotAssets" withObject:obj listener:callback thisObject:nil];
            [assets autorelease];
        }
    }];
}



@end
