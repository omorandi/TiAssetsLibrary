var groups = require('groups');

var single_asset = require('single_asset');

single_asset.getFirstAsset();


var win1 = groups.createGroupsWindow();
win1.tabBarHidden = true;

var tabGroup = Ti.UI.createTabGroup();
var tab1 = Ti.UI.createTab({
	window: win1
});

groups.tab = tab1;

tabGroup.addTab(tab1);

tabGroup.open();
