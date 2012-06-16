// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});

win.open();

// TODO: write your module tests here
var assetslibrary = require('ti.assetslibrary');
Ti.API.info("module is => " + assetslibrary);


var table = Ti.UI.createTableView({});
win.add(table);




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
};

var errorCb = function(e) {
	Ti.API.error('error: ' + e.error);
};

var groups = assetslibrary.getGroups([assetslibrary.AssetsGroupTypeAll], successCb, errorCb);

