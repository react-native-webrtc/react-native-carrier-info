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

RCT_EXPORT_METHOD(allowsVOIP:(RCTResponseSenderBlock)callback)
{
    CTTelephonyNetworkInfo *nInfo = [[CTTelephonyNetworkInfo alloc] init];
    BOOL allowsVoip = [[nInfo subscriberCellularProvider] allowsVOIP];
    callback(@[[NSNumber numberWithBool:allowsVoip]]);
}

RCT_EXPORT_METHOD(carrierName:(RCTResponseSenderBlock)callback)
{
    CTTelephonyNetworkInfo *nInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *carrierName = [[nInfo subscriberCellularProvider] carrierName];
    if(carrierName)
    {
        callback(@[carrierName]);
    }
    else
    {
        callback(@[@"nil"]);
    }
}

RCT_EXPORT_METHOD(isoCountryCode:(RCTResponseSenderBlock)callback)
{
    CTTelephonyNetworkInfo *nInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *iso = [[nInfo subscriberCellularProvider] isoCountryCode];
    if(iso)
    {
        callback(@[iso]);
    }
    else
    {
        callback(@[@"nil"]);
    }
}

RCT_EXPORT_METHOD(mobileCountryCode:(RCTResponseSenderBlock)callback)
{
    CTTelephonyNetworkInfo *nInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *mcc = [[nInfo subscriberCellularProvider] mobileCountryCode];
    if(mcc)
    {
        callback(@[mcc]);
    }
    else
    {
        callback(@[@"nil"]);
    }
}

RCT_EXPORT_METHOD(mobileNetworkCode:(RCTResponseSenderBlock)callback)
{
    CTTelephonyNetworkInfo *nInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *mnc = [[nInfo subscriberCellularProvider] mobileNetworkCode];
    if(mnc)
    {
        callback(@[mnc]);
    }
    else
    {
        callback(@[@"nil"]);
    }
}

@end
