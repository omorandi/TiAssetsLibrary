var assetslibrary = require('ti.assetslibrary');

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

var authStatuses = [
	'NotDetermined',
	'Restricted',
	'StatusDenied',
	'StatusAuthorized'
];

var logAuthStatus = function() {
	var authStatus = assetslibrary.authorizationStatus;
	var authText = authStatus !== null ? authStatuses[authStatus] : 'not available in this version of iOS';
	Ti.API.info('Authorization status: ' + authText);
};

logAuthStatus();

Ti.App.addEventListener('resumed', function() {
	logAuthStatus();
});

assetslibrary.addEventListener('libraryChanged', function(e) {
	Ti.API.info(e);
});
