/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "Asset.h"
#import <CoreLocation/CoreLocation.h>
#import "TiBlob.h"
#import "AssetRepresentation.h"

@implementation Asset



-(id)initWithAsset:(ALAsset*)alAsset
{
    self = [super init];
    if (self)
    {
        asset = [alAsset retain];
    }
    return self;
}


-(void)dealloc
{
    RELEASE_TO_NIL(asset);
    [super dealloc];
}

-(NSString*)type
{
    return [asset valueForProperty:ALAssetPropertyType];
}

-(NSDictionary*)location
{
    CLLocation *assetLocation = [asset valueForProperty:ALAssetPropertyLocation];
    if (!assetLocation) {
        return nil;
    }
    NSDictionary *loc = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithDouble:assetLocation.coordinate.latitude], @"latitude", 
                         [NSNumber numberWithDouble:assetLocation.coordinate.longitude], @"longitude", 
                         [NSNumber numberWithDouble:assetLocation.altitude], @"altitude", nil];
    return loc;
}

-(NSNumber*)duration
{
    id assetDuration = [asset valueForProperty:ALAssetPropertyDuration];
    if (assetDuration == ALErrorInvalidProperty) {
        return nil;
    }
    return assetDuration;
}

-(NSNumber*)orientation
{
    return [asset valueForProperty:ALAssetPropertyOrientation];
}

-(NSDate*)date
{
    return [asset valueForProperty:ALAssetPropertyDate];
}

-(NSArray*)representations
{
    NSMutableArray *reps = [[NSMutableArray alloc] init];
    NSArray *assetRepresentations = [asset valueForProperty:ALAssetPropertyRepresentations];
    
    for (NSString* r in assetRepresentations) {
        ALAssetRepresentation *rep = [asset representationForUTI:r];
        AssetRepresentation *repProxy = [[[AssetRepresentation alloc] initWithAssetRepresentation:rep] autorelease];
        [reps addObject:repProxy];
    }
    
    return [reps autorelease];
}

-(NSDictionary*)URLs
{
    return [asset valueForProperty:ALAssetPropertyURLs];
}

-(Asset*)originalAsset
{
    if (asset.originalAsset == nil) {
        return nil;
    }
    return [[[Asset alloc] initWithAsset:asset.originalAsset] autorelease];
}

-(NSNumber*)editable
{
    return [NSNumber numberWithBool:asset.editable];
}

-(TiBlob*)aspectRatioThumbnail
{
    UIImage *img = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
    return [[[TiBlob alloc] initWithImage:img] autorelease];
}

-(TiBlob*)thumbnail
{
    UIImage *img = [UIImage imageWithCGImage:[asset thumbnail]];
    return [[[TiBlob alloc] initWithImage:img] autorelease];
}


-(AssetRepresentation*)defaultRepresentation
{
    return [[[AssetRepresentation alloc] initWithAssetRepresentation:asset.defaultRepresentation] autorelease];
}


-(AssetRepresentation*)getRepresentationForUTI:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    
    return [[[AssetRepresentation alloc] initWithAssetRepresentation:[asset representationForUTI:args]] autorelease];
}




@end
