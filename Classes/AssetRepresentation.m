/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "AssetRepresentation.h"
#import "TiBlob.h"

@implementation AssetRepresentation

-(id)initWithAssetRepresentation:(ALAssetRepresentation*)assetRep
{
    self = [super init];
    if (self)
    {
        assetRepresentation = [assetRepresentation retain];
    }
    return self;
}

-(void)dealloc
{
    RELEASE_TO_NIL(assetRepresentation);
    [super dealloc];
}

-(NSString*)filename
{
    return [assetRepresentation filename];
}

-(TiBlob*)fullResolutionImage
{
    UIImage *img = [UIImage imageWithCGImage:assetRepresentation.fullResolutionImage];
    return [[[TiBlob alloc] initWithImage:img] autorelease];
}

-(TiBlob*)fullScreenImage
{
    UIImage *img = [UIImage imageWithCGImage:assetRepresentation.fullScreenImage];
    return [[[TiBlob alloc] initWithImage:img] autorelease];
}


-(NSDictionary*)metadata
{
    return [assetRepresentation metadata];
}

-(NSNumber*)orientation
{
    return [NSNumber numberWithInt:assetRepresentation.orientation];
}

-(NSNumber*)scale
{
    return [NSNumber numberWithDouble:assetRepresentation.scale];
}

-(NSNumber*)size
{
    return [NSNumber numberWithLongLong:assetRepresentation.size];
}

-(NSString*)url
{
    return [[assetRepresentation url] absoluteString];
}

-(NSString*)UTI
{
    return [assetRepresentation UTI];
}

@end
