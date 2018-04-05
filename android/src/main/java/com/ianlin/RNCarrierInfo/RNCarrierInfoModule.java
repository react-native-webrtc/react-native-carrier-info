package com.ianlin.RNCarrierInfo;

import android.content.Context;
import android.telephony.TelephonyManager;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;

public class RNCarrierInfoModule extends ReactContextBaseJavaModule {
    private final static String TAG = RNCarrierInfoModule.class.getCanonicalName();
    private final static String E_NO_CARRIER_NAME = "no_carrier_name";
    private final static String E_NO_ISO_COUNTRY_CODE = "no_iso_country_code";
    private final static String E_NO_MOBILE_COUNTRY_CODE = "no_mobile_country_code";
    private final static String E_NO_MOBILE_NETWORK = "no_mobile_network";
    private final static String E_NO_NETWORK_OPERATOR = "no_network_operator";
    private TelephonyManager mTelephonyManager;

    public RNCarrierInfoModule(ReactApplicationContext reactContext) {
        super(reactContext);
        mTelephonyManager = (TelephonyManager) reactContext.getSystemService(Context.TELEPHONY_SERVICE);
    }

    @Override
    public String getName() {
        return "RNCarrierInfo";
    }

    @ReactMethod
    public void carrierName(Promise promise) {
        String carrierName = mTelephonyManager.getNetworkOperatorName();
        if (carrierName != null) {
            promise.resolve(carrierName);
        } else {
            promise.reject(E_NO_CARRIER_NAME, "No carrier name");
        }
    }

    @ReactMethod
    public void isoCountryCode(Promise promise) {
        String iso = mTelephonyManager.getNetworkCountryIso();
        if (iso != null) {
            promise.resolve(iso);
        } else {
            promise.reject(E_NO_ISO_COUNTRY_CODE, "No iso country code");
        }
    }

    @ReactMethod
    public void mobileCountryCode(Promise promise) {
        String networkOperator = mTelephonyManager.getNetworkOperator();
        if (mcc != null) {
            int mcc = Integer.parseInt(networkOperator.substring(0, 3));
            promise.resolve(mcc);
        } else {
            promise.reject(E_NO_MOBILE_COUNTRY_CODE, "No mobile country code");
        }
    }

    @ReactMethod
    public void mobileNetworkCode(Promise promise) {
        String networkOperator = mTelephonyManager.getNetworkOperator();
        if (mnc != null) {
            int mnc = Integer.parseInt(networkOperator.substring(3));
            promise.resolve(mnc);
        } else {
            promise.reject(E_NO_MOBILE_NETWORK, "No mobile network code");
        }
    }

    // return MCC + MNC, e.g. 46697
    @ReactMethod
    public void mobileNetworkOperator(Promise promise) {
        String operator = mTelephonyManager.getNetworkOperator();
        if (operator != null) {
            promise.resolve(operator);
        } else {
            promise.reject(E_NO_NETWORK_OPERATOR, "No mobile network operator");
        }
    }
}
