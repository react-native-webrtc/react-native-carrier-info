//
//  RNCarrierInfo.m
//  RNCarrierInfo
//
//  Created by Matthew Knight on 09/05/2015.
//  Copyright (c) 2015 Anarchic Knight. All rights reserved.
//

#import "RNCarrierInfo.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation RNCarrierInfo

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(allowsVOIP:(RCTPromiseResolveBlock)resolve
                    rejecter:(RCTPromiseRejectBlock)reject)
{
    CTTelephonyNetworkInfo *nInfo = [[CTTelephonyNetworkInfo alloc] init];
    BOOL allowsVoip = [[nInfo subscriberCellularProvider] allowsVOIP];
    resolve([NSNumber numberWithBool:allowsVoip]);
}

RCT_EXPORT_METHOD(carrierName:(RCTPromiseResolveBlock)resolve
                     rejecter:(RCTPromiseRejectBlock)reject)
{
    CTTelephonyNetworkInfo *nInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *carrierName = [[nInfo subscriberCellularProvider] carrierName];
    if(carrierName)
    {
        resolve(carrierName);
    }
    else
    {
        reject(@"no_carrier_name", @"Carrier Name cannot be resolved", nil);
    }
}

RCT_EXPORT_METHOD(isoCountryCode:(RCTPromiseResolveBlock)resolve
                        rejecter:(RCTPromiseRejectBlock)reject)
{
    CTTelephonyNetworkInfo *nInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *iso = [[nInfo subscriberCellularProvider] isoCountryCode];
    if(iso)
    {
        resolve(iso);
    }
    else
    {
        reject(@"no_iso_country_code", @"ISO country code cannot be resolved", nil);
    }
}

RCT_EXPORT_METHOD(mobileCountryCode:(RCTPromiseResolveBlock)resolve
                           rejecter:(RCTPromiseRejectBlock)reject)
{
    CTTelephonyNetworkInfo *nInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *mcc = [[nInfo subscriberCellularProvider] mobileCountryCode];
    if(mcc)
    {
        resolve(mcc);
    }
    else
    {
        reject(@"no_mobile_country_code", @"Mobile country code cannot be resolved", nil);
    }
}

RCT_EXPORT_METHOD(mobileNetworkCode:(RCTPromiseResolveBlock)resolve
                           rejecter:(RCTPromiseRejectBlock)reject)
{
    CTTelephonyNetworkInfo *nInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *mnc = [[nInfo subscriberCellularProvider] mobileNetworkCode];
    if(mnc)
    {
        resolve(mnc);
    }
    else
    {
        reject(@"no_mobile_network", @"Mobile network code cannot be resolved", nil);
    }
}

// return MCC + MNC, e.g. 46697
RCT_EXPORT_METHOD(mobileNetworkOperator:(RCTPromiseResolveBlock)resolve
                               rejecter:(RCTPromiseRejectBlock)reject)
{
    CTTelephonyNetworkInfo *nInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *mcc = [[nInfo subscriberCellularProvider] mobileCountryCode];
    NSString *mnc = [[nInfo subscriberCellularProvider] mobileNetworkCode];
    NSString *operator = [NSString stringWithFormat: @"%@%@", mcc, mnc];
    if (operator)
    {
        resolve(operator);
    }
    else
    {
        reject(@"no_network_operator", @"Mobile network operator code cannot be resolved", nil);
    }
}

RCT_EXPORT_METHOD(mobileTechnology:(RCTPromiseResolveBlock)resolve
                           rejecter:(RCTPromiseRejectBlock)reject)
{
    /*
    https://stackoverflow.com/questions/11049660/detect-carrier-connection-type-3g-edge-gprs/20840971#20840971
    */

    NSString* mobileTechnology = [NSString string];

    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)
    {
        CTTelephonyNetworkInfo *nInfo = [CTTelephonyNetworkInfo new];

        /*
        NSLog(@"Current radio access technology: %@", nInfo.currentRadioAccessTechnology);
        [NSNotificationCenter.defaultCenter addObserverForName:CTRadioAccessTechnologyDidChangeNotification
                                                        object:nil
                                                         queue:nil
                                                    usingBlock:^(NSNotification *note)
        {
            NSLog(@"New radio access technology: %@", nInfo.currentRadioAccessTechnology);
        }];
        */

        if ([nInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
            mobileTechnology = @"2g";
        } else if ([nInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge]) {
            mobileTechnology = @"2g";
        } else if ([nInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyWCDMA]) {
            mobileTechnology = @"3g";
        } else if ([nInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSDPA]) {
            mobileTechnology = @"3g";
        } else if ([nInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSUPA]) {
            mobileTechnology = @"3g";
        } else if ([nInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
            mobileTechnology = @"2g";
        } else if ([nInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]) {
            mobileTechnology = @"3g";
        } else if ([nInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]) {
            mobileTechnology = @"3g";
        } else if ([nInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]) {
            mobileTechnology = @"3g";
        } else if ([nInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyeHRPD]) {
            mobileTechnology = @"3g";
        } else if ([nInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
            mobileTechnology = @"4g";
        }
    }
    else
    {
        mobileTechnology = @"unknown";
    }

    if(mobileTechnology)
    {
        resolve(mobileTechnology);
    }
    else
    {
        reject(@"no_mobile_technology", @"Mobile radio access technology cannot be resolved", nil);
    }
}

@end

