// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.

require('date_util');

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white',
	title: 'Groups',
	tabBarHidden: true
});



// TODO: write your module tests here
var assetslibrary = require('ti.assetslibrary');
Ti.API.info("module is => " + assetslibrary);


var table = Ti.UI.createTableView({});
win.add(table);


var tabGroup = Ti.UI.createTabGroup();
var tab = Ti.UI.createTab({
	window: win
});

tabGroup.addTab(tab);


var detailRow = function(name, val) {
	var row = Ti.UI.createTableViewRow({
		height: 44
	});
	var title = Ti.UI.createLabel({
		left: 10,
		width: 150,
		font: {fontSize: 16, fontWeight: 'bold'},
		textAlign: 'left',
		color: 'black',
		text: name
	});

	var value = Ti.UI.createLabel({
		right: 10,
		width: 150,
		font: {fontSize: 14},
		textAlign: 'right',
		color: '#aaa',
		text: val
	});
	row.add(title);
	row.add(value);
	return row;
};


var assetOrientation = function(asset) {
	switch (asset.orientation) {
		case assetslibrary.AssetOrientationUp:
			return 'UP';
		case assetslibrary.AssetOrientationDown:
			return 'DOWN';
		case assetslibrary.AssetOrientationLeft:
			return 'LEFT';
		case assetslibrary.AssetOrientationRight:
			return 'RIGHT';
		case assetslibrary.AssetOrientationUpMirrored:
			return 'UP-mirrored';
		case assetslibrary.AssetOrientationDownMirrored:
			return 'DOWN-mirrored';
		case assetslibrary.AssetOrientationLeftMirrored:
			return 'LEFT-mirrored';
		case assetslibrary.AssetOrientationRightMirrored:
			return 'RIGHT-mirrored';
		default:
			return 'undefined';
	}
};

var createDetailsWin = function(asset) {
	var detailsWin = Ti.UI.createWindow({
		backgroundColor: 'white',
		title: 'Asset Details'
	});

	var detailsTable = Ti.UI.createTableView({
		separatorColor: '#eee'
	});
	detailsWin.add(detailsTable);

	var sections = [];
	var section1 = Ti.UI.createTableViewSection();
	section1.headerTitle = 'general info';
	
	section1.add(detailRow('type:', asset.type));
	section1.add(detailRow('duration:', asset.duration));
	section1.add(detailRow('orientation:', assetOrientation(asset)));
	section1.add(detailRow('date:', asset.date.shortString(true)));
	if (asset.location) {
		section1.add(detailRow('location:', asset.location.latitude + ', ' + asset.location.longitude));
	}
	sections.push(section1);
	//for every asset we can have several representations
	var representations = asset.representations;
	if (representations) {
		for (var i = 0; i < representations.length; i++) {
			var rep = representations[i];
			var section = Ti.UI.createTableViewSection();
			section.headerTitle = 'representation: ' + rep.UTI;
			section.add(detailRow('url:', rep.url));
			section.add(detailRow('filename:', rep.filename));
			section.add(detailRow('orientation', assetOrientation(rep)));
			section.add(detailRow('size', rep.size));
			section.add(detailRow('scale', rep.scale));
			section.add(detailRow('metadata', JSON.stringify(rep.metadata)));
			sections.push(section);
		}
	}
	detailsTable.data = sections;
	tab.open(detailsWin, {animated: true});

};


var createAssetsWin = function(group) {
	
	var assetsWin = Ti.UI.createWindow({
		backgroundColor: 'white',
		title: 'Assets'
	});

	var assetsTable = Ti.UI.createTableView();
	assetsWin.add(assetsTable);
	
	var startTime = new Date().getTime();

	group.getAssets(function(e) {
		var endTime = new Date().getTime();
		Ti.API.info('Got assets in ' + (endTime - startTime) + 'ms');
		var assetsList = e.assets;
		var rows = [];
		for (var i = 0; i < assetsList.assetsCount; i++) {
			var asset = assetsList.getAssetAtIndex(i);
			var row = Ti.UI.createTableViewRow({height: 44, hasChild: true});
			var img = Ti.UI.createImageView({
				left: 5,
				height: 40,
				width: 40,
				image: asset.thumbnail
			});
			var title = Ti.UI.createLabel({
				left: 50,
				text: asset.type
			});
			row.add(img);
			row.add(title);
			rows.push(row);
		}
		assetsTable.data = rows;
		assetsTable.addEventListener('click', function(e) {
			createDetailsWin(assetsList.getAssetAtIndex(e.index));
		});

	});
	tab.open(assetsWin, {animated: true});

};


var successCb = function(e) {
	var groups = e.groups;
	Ti.API.info('Got ' + groups.length + ' groups');
	var rows = groups.map(function(group) {
		Ti.API.info('Group: ' + group.name + ' n assets: ' + group.numberOfAssets);
		var row = Ti.UI.createTableViewRow({height: 44});
		var img = Ti.UI.createImageView({
			left: 5,
			height: 40,
			width: 40,
			image: group.posterImage,
			borderRadius: 5
		});
		var title = Ti.UI.createLabel({
			left: 50,
			text: group.name
		});
		row.add(img);
		row.add(title);
		return row;
	});
	table.data = rows;
	table.addEventListener('click', function(e) {
		createAssetsWin(groups[e.index]);
	});
};

var errorCb = function(e) {
	Ti.API.error('error: ' + e.error);
};

var groups = assetslibrary.getGroups([assetslibrary.AssetsGroupTypeAll], successCb, errorCb);


tabGroup.open();
