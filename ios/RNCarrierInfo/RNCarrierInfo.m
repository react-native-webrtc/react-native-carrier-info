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
        resolve(@"nil");
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
        resolve(@"nil");
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
        resolve(@"nil");
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
        resolve(@"nil");
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
    if (operator) {
        resolve(operator);
    }
    else {
        resolve(@"nil");
    }
}

@end
