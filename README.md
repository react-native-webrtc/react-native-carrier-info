## 08/01/2017 - This project is no longer actively maintained. It will remain here so it can still be used but there will be no further updates or bug fixes. It likely needs a new major version for the recent changes in RN 0.40. If another user wants to consider taking ownership of the repo then please contact me

# react-native-carrier-info

React Native module bridge to obtain information about the user’s home cellular service provider.

Makes use of the following native iOS classes: [CTTelephonyNetworkInfo](https://developer.apple.com/library/prerelease/ios/documentation/NetworkingInternet/Reference/CTTelephonyNetworkInfo/index.html#//apple_ref/occ/cl/CTTelephonyNetworkInfo) & [CTCarrier](https://developer.apple.com/library/prerelease/ios/documentation/NetworkingInternet/Reference/CTCarrier/index.html#//apple_ref/doc/c_ref/CTCarrier)

## API

```js
boolean allowsVOIP(callback) - Indicates if the carrier allows VoIP calls to be made on its network.
```

If you configure a device for a carrier and then remove the SIM card, this property retains the Boolean value indicating the carrier’s policy regarding VoIP.

```js
string carrierName(callback) - The name of the user’s home cellular service provider.
```

This string is provided by the carrier and formatted for presentation to the user. The value does not change if the user is roaming; it always represents the provider with whom the user has an account.

If you configure a device for a carrier and then remove the SIM card, this property retains the name of the carrier.

The value for this property is 'nil' if the device was never configured for a carrier.

```js
string isoCountryCode(callback) - The ISO country code for the user’s cellular service provider.
```

This property uses the ISO 3166-1 country code representation.

The value for this property is 'nil' if any of the following apply:

* The device is in Airplane mode.
* There is no SIM card in the device.
* The device is outside of cellular service range.

```js
string mobileCountryCode(callback) - The mobile country code (MCC) for the user’s cellular service provider.
```

MCCs are defined by ITU-T Recommendation E.212, “List of Mobile Country or Geographical Area Codes.”

The value for this property is 'nil' if any of the following apply:

* There is no SIM card in the device.
* The device is outside of cellular service range.

The value may be 'nil' on hardware prior to iPhone 4S when in Airplane mode.

```js
string mobileNetworkCode(callback) - The mobile network code (MNC) for the user’s cellular service provider.
```

The value for this property is 'nil' if any of the following apply:

* There is no SIM card in the device.
* The device is outside of cellular service range.

The value may be 'nil' on hardware prior to iPhone 4S when in Airplane mode.

## Getting Started (and running the demo project)

1. From inside your project run `npm install react-native-carrier-info --save`
2. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
3. Go to `node_modules` ➜ `react-native-carrier-info` and add `RNCarrierInfo.xcodeproj`
4. In XCode, in the project navigator, select your project. Add `libRNCarrierInfo.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
5. Click `RNCarrierInfo.xcodeproj` in the project navigator and go the `Build Settings` tab. Make sure 'All' is toggled on (instead of 'Basic'). Look for `Header Search Paths` and make sure it contains both `$(SRCROOT)/../react-native/React` and `$(SRCROOT)/../../React` - mark both as `recursive`.
6. Set up the project to run on your device (iOS simulator does not report cellular provider info)
7. Run your project (`Cmd+R`)

## Usage Example

```js
var React = require('react-native');
var CarrierInfo = require('NativeModules').RNCarrierInfo;

// inside your code where you would like to retrieve carrier info
CarrierInfo.allowsVOIP(
	(result) => AlertIOS.alert('Allows VoIP', JSON.stringify(result))
);

CarrierInfo.carrierName(
	(result) => AlertIOS.alert('Carrier Name', result)
);

CarrierInfo.isoCountryCode(
	(result) => AlertIOS.alert('ISO', result)
);

CarrierInfo.mobileCountryCode(
	(result) => AlertIOS.alert('MCC', result)
);

CarrierInfo.mobileNetworkCode(
	(result) => AlertIOS.alert('MNC', result)
);
```

There is an example project supplied with the repo in the RNCarrierInfoDemo folder. The sample app needs to be run on a device as the simulator does not report cellular provider info.
