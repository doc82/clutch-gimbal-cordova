//
//  GimbalMgr.m
//
//  Created by Bruce Bjorklund on 02/16/2015.
//
//

#import "GimbalMgr.h"
#import <Gimbal/Gimbal.h>

@interface GimbalMgr () <GMBLBeaconManagerDelegate, GMBLPlaceManagerDelegate>

@property (nonatomic) GMBLPlaceManager *placeManager;
@property (nonatomic) GMBLBeaconManager *beaconManager;

@property (nonatomic) NSString * _beaconEventCallback;
@property (nonatomic) NSString * _placeEventCallback;
@property (nonatomic) NSDate * lastAlertSent;

@end

@implementation GimbalMgr

// Public Hooks
- (void)startService:(CDVInvokedUrlCommand*)command
{
// TODO: do we need this?
	NSString *appSecret = [[command arguments] objectAtIndex:0];

	if (appSecret != nil) {
		[Gimbal setAPIKey:appSecret options:nil];
		NSString * successMsg = @"Started Service!";

		// self.placeManager = [GMBLPlaceManager new];
		// self.placeManager.delegate = self;
		// [GMBLPlaceManager startMonitoring];

		// self.beaconManager = [GMBLBeaconManager new];
		// self.beaconManager.delegate = self;
		// [self.beaconManager startListening];

		CDVPluginResult* pluginResult = nil;
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: successMsg];
		[pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}
	else
	{
		CDVPluginResult* pluginResult = nil;
		NSString * errorMsg = @"Error! No App Secret Key!";
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: errorMsg];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}
}

- (void)stopService:(CDVInvokedUrlCommand*)command {
	[GMBLPlaceManager stopMonitoring];
	[self.beaconManager stopListening];

}

- (void)setPlaceEventCallback:(CDVInvokedUrlCommand*)command
{
		self._placeEventCallback = command.callbackId;
}

- (void)setBeaconEventCallback:(CDVInvokedUrlCommand*)command
{
		self._beaconEventCallback = command.callbackId;
}


// beaconManager Delegate
- (void)beaconManager:(GMBLBeaconManager *)manager didReceiveBeaconSighting:(GMBLBeaconSighting *)sighting
{
	//This will be invoked when a user sights a beacon
	NSNumber *RSSI = [NSNumber numberWithInteger:sighting.RSSI];

	NSDictionary *sightingResult =
	@{
		@"name": sighting.beacon.name,
		@"rssi": RSSI,
		@"identifier": sighting.beacon.identifier
	};

	CDVPluginResult* pluginResult = nil;
	pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:sightingResult];
	[pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:self._beaconEventCallback];
}

//  placeManager delegate - throws event when enter a place
- (void)placeManager:(GMBLPlaceManager *)manager didBeginVisit:(GMBLVisit *)visit
{
	NSDictionary *visitResult =
	@{
		@"name": visit.place.name,
		@"place": visit.place.identifier,
		@"arrivalDate":  visit.arrivalDate,
		@"departureDate":  visit.departureDate,
	};

	CDVPluginResult* pluginResult = nil;
	pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:visitResult];
	[pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:self._placeEventCallback];
}

// throws event when exit a place
- (void)placeManager:(GMBLPlaceManager *)manager didEndVisit:(GMBLVisit *)visit
{
	NSDictionary *visitResult =
	@{
		@"name": visit.place.name,
		@"place": visit.place.identifier,
		@"arrivalDate":  visit.arrivalDate,
		@"departureDate":  visit.departureDate,
	};

	CDVPluginResult* pluginResult = nil;
	pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:visitResult];
	[pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:self._placeEventCallback];
}

@end
