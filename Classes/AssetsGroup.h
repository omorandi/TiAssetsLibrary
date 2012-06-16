/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import "AssetsLibrary/ALAssetsGroup.h"
#import "TiBlob.h"


const NSString *kAssetsFilterAll = @"AssetsFilterAll";
const NSString *kAssetsFilterPhotos = @"AssetsFilterPhotos";
const NSString *kAssetsFilterVideos = @"AssetsFilterVideos";


@interface AssetsGroup : TiProxy {

    ALAssetsGroup *assetsGroup;
    NSString *currentAssetsFilter;
}

-(id)initWithALAssetsGroup:(ALAssetsGroup*)group;

-(NSString*)name;

-(NSNumber*)type;

-(NSString*)persistentID;

-(NSString*)URL;

-(NSNumber*)numberOfAssets;

-(TiBlob*)posterImage;


@end
