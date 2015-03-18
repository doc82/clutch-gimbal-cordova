//
//  GimbalMgr.m
//
//  Created by Bruce Bjorklund on 02/16/2015.
//
//
//

#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>

@interface GimbalMgr : CDVPlugin

- (void)startService:(CDVInvokedUrlCommand*)command;
- (void)stopService:(CDVInvokedUrlCommand*)command;

- (void)setPlaceEventCallback:(CDVInvokedUrlCommand*)command;
- (void)setBeaconEventCallback:(CDVInvokedUrlCommand*)command;


@end
