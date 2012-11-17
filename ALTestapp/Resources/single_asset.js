var assetslibrary = require('ti.assetslibrary');

exports.getFirstAsset = function() {

	var successCb = function(e) {
		var groups = e.groups;
		if (!groups || groups.length === 0) {
			Ti.API.warn('SINGLE_ASSET: Got no groups');
			return;
		}

		Ti.API.info('SINGLE_ASSET: Got ' + groups.length + ' groups');

		//let's consider the first group
		var group = groups[0];

		Ti.API.info('SINGLE_ASSET: getting assets for group 0');
		//get assets for that group
		group.getAssets(function(e) {
			var assetsList = e.assets;
			if (!assetsList || assetsList.assetsCount === 0) {
				Ti.API.warn('SINGLE_ASSET: Got no assets');
				return;
			}

			Ti.API.info('SINGLE_ASSET: Got ' + assetsList.assetsCount + ' assets');
			//let's consider the first asset
			var asset = assetsList.getAssetAtIndex(0);
			var location = asset.location;

			Ti.API.info('location: ' + JSON.stringify(location));

			//let's consider only the default representation
			var rep = asset.defaultRepresentation;

			var url = rep.url;

			//OK let's test assetslibrary.getAsset();
			Ti.API.info('SINGLE_ASSET: getting asset from URL: ' + url);

			assetslibrary.getAsset(url, function(e) {
				Ti.API.info('SINGLE_ASSET: Got Asset with URL: ' + e.asset.URLs[rep.UTI]);
			}, function (e) {
				Ti.API.error('SINGLE_ASSET: error:  ' + e.error);
			});

		});
	};

	var errorCb = function(e) {
		Ti.API.error('error: ' + e.error);
	};

	Ti.API.info('SINGLE_ASSET: Getting groups');
	var groups = assetslibrary.getGroups([assetslibrary.AssetsGroupTypeAll], successCb, errorCb);
};

