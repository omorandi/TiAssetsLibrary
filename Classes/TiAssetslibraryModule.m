/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiAssetslibraryModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "KrollCallback.h"
#import "AssetsGroup.h"


@implementation TiAssetslibraryModule

@synthesize assetsLib = _assetsLib;

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"dad3b8e4-e244-4af3-a889-d8bb65a73274";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.assetslibrary";
}


-(void)initAssetsLib
{
    if (!self.assetsLib) 
    {
        self.assetsLib = [[ALAssetsLibrary alloc] init];
    }
    
}



#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
    self.assetsLib = nil;
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}


-(int)groupTypesFlags:(NSArray*)types
{
    int flags = 0;
    for (NSNumber *groupType in types) {
        flags |= [groupType intValue];
    }
    
    return flags;
}


#pragma Public APIs

MAKE_SYSTEM_PROP(AssetsGroupTypeLibrary,  ALAssetsGroupLibrary);
MAKE_SYSTEM_PROP(AssetsGroupTypeAlbum, ALAssetsGroupAlbum);
MAKE_SYSTEM_PROP(AssetsGroupTypeEvent, ALAssetsGroupEvent);
MAKE_SYSTEM_PROP(AssetsGroupTypeFaces, ALAssetsGroupFaces);
MAKE_SYSTEM_PROP(AssetsGroupTypeSavedPhotos, ALAssetsGroupSavedPhotos);
MAKE_SYSTEM_PROP(AssetsGroupTypePhotoStream, ALAssetsGroupPhotoStream);
MAKE_SYSTEM_PROP(AssetsGroupTypeAll, ALAssetsGroupAll);


MAKE_SYSTEM_PROP(AssetOrientationUp, ALAssetOrientationUp);
MAKE_SYSTEM_PROP(AssetOrientationDown, ALAssetOrientationDown);
MAKE_SYSTEM_PROP(AssetOrientationLeft, ALAssetOrientationLeft);
MAKE_SYSTEM_PROP(AssetOrientationRight, ALAssetOrientationRight);
MAKE_SYSTEM_PROP(AssetOrientationUpMirrored, ALAssetOrientationUpMirrored);
MAKE_SYSTEM_PROP(AssetOrientationDownMirrored, ALAssetOrientationDownMirrored);
MAKE_SYSTEM_PROP(AssetOrientationLeftMirrored, ALAssetOrientationLeftMirrored);
MAKE_SYSTEM_PROP(AssetOrientationRightMirrored, ALAssetOrientationRightMirrored);

MAKE_SYSTEM_STR(AssetTypePhoto, ALAssetTypePhoto);
MAKE_SYSTEM_STR(AssetTypeVideo, ALAssetTypeVideo);
MAKE_SYSTEM_STR(AssetTypeUnknown, ALAssetTypeUnknown);

MAKE_SYSTEM_STR(AssetsFilterAll, kAssetsFilterAll);
MAKE_SYSTEM_STR(AssetsFilterPhotos, kAssetsFilterPhotos);
MAKE_SYSTEM_STR(AssetsFilterVideos, kAssetsFilterVideos);



-(void)getGroups:(id)args
{
    ENSURE_ARG_COUNT(args, 3);
    
    id arg1 = [args objectAtIndex:0];
    ENSURE_TYPE(arg1, NSArray);
    
    int flags = [self groupTypesFlags:arg1];
    
    id successCb = [args objectAtIndex:1];
    ENSURE_TYPE(successCb, KrollCallback);
    
    id errorCb = [args objectAtIndex:2];
    ENSURE_TYPE(errorCb, KrollCallback);
    
    
    [self initAssetsLib];
    
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    
    [self.assetsLib enumerateGroupsWithTypes:flags usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [groups addObject:[[[AssetsGroup alloc] initWithALAssetsGroup:group] autorelease]];
        }
        else {
            NSDictionary *obj = [NSDictionary dictionaryWithObject:groups forKey:@"groups"];
            [self _fireEventToListener:@"gotGroups" withObject:obj listener:successCb thisObject:nil];
            [groups autorelease];
        }
        
    } failureBlock:^(NSError *error) {
        NSDictionary *obj = [NSDictionary dictionaryWithObject:error.description forKey:@"error"];
        [self _fireEventToListener:@"error" withObject:obj listener:errorCb thisObject:nil];
    }];
    
    
    
}



@end
