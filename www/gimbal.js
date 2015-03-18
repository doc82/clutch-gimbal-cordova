/*global cordova*/
var gimbalMgrName = "GimbalMgr";

var gimbalMgr = {
  startService: function(successCallbak, errorCallback, params) {
    cordova.exec(successCallbak, errorCallback, gimbalMgrName, 'startService', [params]);
  },

  stopService: function(successCallbak, errorCallback) {
    cordova.exec(successCallbak, errorCallback, gimbalMgrName, 'stopService', []);
  },

  setPlaceEventCallback: function(successCallbak, errorCallback) {
    cordova.exec(successCallbak, errorCallback, gimbalMgrName, 'setPlaceEventCallback', []);
  },

  setBeaconEventCallback: function(successCallbak, errorCallback) {
    cordova.exec(successCallbak, errorCallback, gimbalMgrName, 'setBeaconEventCallback', []);
  }
};

module.exports = gimbalMgr;
