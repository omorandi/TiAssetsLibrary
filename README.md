# TiAssetsLibrary Module

## Description

This iOS module extends the Ti SDK, enabling access to the functionalities provided by the iOS  [AssetsLibrary framework](http://developer.apple.com/library/ios/#documentation/AssetsLibrary/Reference/AssetsLibraryFramework/_index.html).

The module provides an almost 1:1 mapping on the features exposed by the underlying framework.

## Building and installing the TiAssetsLibrary Module ##

### BUILD ###

First, you must have your XCode and Titanium Mobile SDKs in place, and have at least read the first few pages of the [iOS Module Developer Guide](https://wiki.appcelerator.org/display/guides/iOS+Module+Development+Guide) from Appcelerator.

The build process can be launched using the build.py script that you find in the module's project root directory.

As a result, the ti.assetslibrary-iphone-0.2.zip file will be generated.

**NOTE: if your Titanium sdk resides in your HOME `~/Library/Application Support/Titanium/` directory, you need to change the value of the `TITANIUM SDK` variable in `titanium.xcconfig` accordingly**


### INSTALL ###
You can either copy the module package (ti.assetslibrary-iphone-0.2.zip) to `/Library/Application\ Support/Titanium` and reference the module in your application (the Titanium SDK will automatically unzip the file in the right place), or manually launch the command:

     unzip -uo ti.assetslibrary-iphone-0.2.zip -d /Library/Application\ Support/Titanium/


**NOTE: if your Titanium sdk resides in your HOME `~/Library/Application Support/Titanium/` directory, change the above command accordingly**

## Referencing the module in your Titanium Mobile application ##

Simply add the following lines to your `tiapp.xml` file:

    <modules>
        <module version="0.2" platform="iphone">ti.assetslibrary</module>
    </modules>

and add this line in your app.js file:

	require('ti.assetslibrary');

## Module Reference

### Module properties
* `authorizationStatus`: integer (read-only) - Returns photo data authorization status for this application (see `AuthorizationStatus` constants below for a list of the possible values returned). **NOTE: this property returns a valid integer value only when executed in iOS versions >= 6.0 - On previous versions of the system a `null` value is returned**


### Module methods

* `getGroups(assetsGroupTypes[], successCb, failureCb)`
	* params
		* assetsGroupTypes - array of constants from **AssetsGroupType**
		* successCb - callback in the form: *function(e)* where `e.groups` is an array of **AssetsGroup** objects
		* failureCb - callback in the form: *function(e)* where `e.error` is a textual description of the error occurred

* `getAsset(url, successCb, failureCb)`
	* params
		* url - url of the asset
		* successCb - callback in the form: *function(e)* where `e.asset` is an **Asset** object
		* failureCb - callback in the form: *function(e)* where `e.error` is a textual description of the error occurred


### Module events
* `libraryChanged`: this event is fired when the contents of the assets library have changed from under the app that is using the data (See [the ALAssetsLibraryChangedNotification Reference](http://developer.apple.com/library/ios/#documentation/AssetsLibrary/Reference/ALAssetsLibrary_Class/Reference/Reference.html) for details). The argument passed to the event callback will be `null` on iOS versions < 6.0, while it will contain a dictionary on iOS versions >= 6.0. The contents of the dictionary are defined in the Apple Reference docs. Depending on the changes made by the user in the library, the affected asset and group URLs are reported in sets. Valid keys for extracting the values from the dictionary are specified in the `AssetsUpdate` constants below.


### Constants:

* `AssetsGroupType` (see the [Reference on Asset Group Types](http://developer.apple.com/library/ios/documentation/AssetsLibrary/Reference/ALAssetsLibrary_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40009722-CH1-SW19) for details)
	* AssetsGroupTypeLibrary
	* AssetsGroupTypeAlbum
	* AssetsGroupTypeEvent
	* AssetsGroupTypeFaces
	* AssetsGroupTypeSavedPhotos
	* AssetsGroupTypePhotoStream
	* AssetsGroupTypeAll

* `AssetOrientation` (see the [ALAssetOrientation Reference](http://developer.apple.com/library/ios/documentation/AssetsLibrary/Reference/ALAssetsLibrary_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40009722-CH1-SW37) for details)
	* AssetOrientationUp
	* AssetOrientationDown
	* AssetOrientationLeft
	* AssetOrientationRight
	* AssetOrientationUpMirrored
	* AssetOrientationDownMirrored
	* AssetOrientationLeftMirrored
	* AssetOrientationRightMirrored

* `AssetFilter` (see the [ALAssetsFilter Reference](http://developer.apple.com/library/ios/#documentation/AssetsLibrary/Reference/ALAssetsFilter_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40009723) for details)
	* AssetsFilterAll
	* AssetsFilterPhotos
	* AssetsFilterVideos

* `AssetType` (see the [Reference on Asset Types](http://developer.apple.com/library/ios/#documentation/AssetsLibrary/Reference/ALAsset_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40009709) for details)
	* AssetTypePhoto
	* AssetTypeVideo
	* AssetTypeUnknown

* `AuthorizationStatus` (see the [Reference on ALAuthorizationStatus constants](http://developer.apple.com/library/ios/documentation/AssetsLibrary/Reference/ALAssetsLibrary_Class/Reference/Reference.html#//apple_ref/c/tdef/ALAuthorizationStatus) for details)
	* AuthorizationStatusNotDetermined
	* AuthorizationStatusRestricted
	* AuthorizationStatusDenied
	* AuthorizationStatusAuthorized

* `AssetsUpdate` (see the [Reference on the ALAssetsLibraryChanged notification keys](http://developer.apple.com/library/ios/documentation/AssetsLibrary/Reference/ALAssetsLibrary_Class/Reference/Reference.html#//apple_ref/doc/constant_group/Notification_Keys) for details)
	* AssetsUpdateUpdatedAssets
	* AssetsUpdateInsertedAssetGroups
	* AssetsUpdateUpdatedAssetGroups
	* AssetsUpdateDeletedAssetGroups

## AssetsGroup object
An **AssetsGroup** object represents an ordered set of the assets managed by the Photos application. The order of the elements is the same as the user sees in the Photos application. An asset can belong to multiple assets groups.

Assets groups themselves are synced via iTunes, created to hold the user’s saved photos or created during camera import.

The **AssetsGroup** object is an almost 1:1 mapping on the [ALAssetsGroup Class](http://developer.apple.com/library/ios/#documentation/AssetsLibrary/Reference/ALAssetsGroup_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40009729) of the AssetsLibrary framework.


### properties

* name: string - name of the group
* type: integer - group type (one of **AssetsGroupType** constants)
* persistentID: string - group’s persistent ID
* URL: string - URL that uniquely identifies the group
* numberOfAssets: integer - number of assets in the group that match the current filter
* posterImage: blob - group’s poster image
* assetsFilter: string - current assets filter (one of **AssetsFilter** constants)

### Methods

* `setAssetsFilter(filter)`
	* params:
		* filter: one of **AssetsFilter** constants

* `getAssets(callback)`
	* params:
		* callback: - callback in the form: *function(e)* where `e.assets` is an **AssetsList** 		object
	* NOTE: assets returned in the **AssetsList** object are filtered according to the current filter set for the `assetsFilter` property of the group


## AssetsList object
The **AssetsList** object is just a wrapper around an underlying array of ALAsset objects, which is used for the lazy creation of **Asset** proxy objects in Titanium.


### properties

* assetsCount: integer - number of assets contained in the list

### methods

* `assetAtIndex(i)` - retrieves the **Asset** object contained at index *i* in the assets list
	* params
		* i: integer - index of the asset inside of the list
	* return: **Asset** object

## Asset object
An **Asset** object represents a photo or a video managed by the Photo application.

Assets can have multiple representations, for example a photo which was captured in RAW and JPG. Different representations of the same asset may have different dimensions.

The **Asset** object is an almost 1:1 mapping on the [ALAsset Class](http://developer.apple.com/library/ios/#documentation/AssetsLibrary/Reference/ALAsset_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40009709) of the AssetsLibrary framework.

### properties

* type: asset type (one of **AssetType** constants)
* location: object in the form `{latitude: latVal, longitude: lonVal}` - location information of the asset.
* duration: double - play time duration of a video asset
* orientation: integer - (one of **AssetOrientation** constants)
* date: Date - creation date of the asset
* representations: Array of **AssetRepresentation** objects - representations available for a given asset
* URLs: dictionary - a dictionary that maps asset representations UTIs to URLs
* originalAsset: **Asset** object - the original asset if the receiver was saved as a modified version of an asset; The property value is `null` if the asset was not saved as a modified version of another asset
* editable: boolean - The property value is `true` if the application is able to edit the asset, and `false` if the application is not able to edit the asset. Applications are only allowed to edit assets that they originally wrote
* aspectRatioThumbnail: blob - aspect ratio thumbnail of the asset
* thumbnail: blob - thumbnail representation of the asset
* defaultRepresentation: **AssetRepresentation** object - asset representation object for the default representation

### methods
* `getRepresentationForUTI(uti)`
	* params
		* uti: string - A UTI describing a representation for the asset
	* return: **AssetRepresentation** object for a given representation UTI


## AssetRepresentation object
An **AssetRepresentation** object encapsulates one of the representations of a given **Asset** object.

A given asset in the library may have more than one representation. For example, if a camera provides RAW and JPEG versions of an image, the resulting asset will have two representations—one for the RAW file and one for the JPEG file.

The **AssetRepresentation** object is an almost 1:1 mapping on the underlying [ALAssetRepresentation Class](http://developer.apple.com/library/ios/#documentation/AssetsLibrary/Reference/ALAssetRepresentation_Class/Reference/Reference.html#//apple_ref/doc/c_ref/ALAssetRepresentation) of the AssetsLibrary framework.

### properties

* filename: string - filename of the representation on disk
* fullResolutionImage: blob - full resolution representation of the asset
* fullScreenImage: blob - representation that is appropriate for displaying full screen
* metadata: dictionary - Returns a dictionary of dictionaries of metadata for the representation
* orientation: integer (one of **AssetOrientation** constants) - representation’s orientation
* scale: double - representation’s scale
* size: integer - size in bytes of the file for the representation
* url: string - persistent URL uniquely identifying the representation
* UTI: string -  representation's UTI


## Author
* Olivier Morandi: [https://github.com/omorandi](https://github.com/omorandi) (@olivier_morandi)

## License

    Copyright (c) 2012 Olivier Morandi

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
