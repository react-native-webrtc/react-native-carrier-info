package com.ianlin.RNCarrierInfo;

import android.content.Context;
import android.telephony.TelephonyManager;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;

public class RNCarrierInfoModule extends ReactContextBaseJavaModule {
    private final static String TAG = RNCarrierInfoModule.class.getCanonicalName();
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
            promise.resolve("nil");
        }
    }

    @ReactMethod
    public void isoCountryCode(Promise promise) {
        String iso = mTelephonyManager.getNetworkCountryIso();
        if (iso != null) {
            promise.resolve(iso);
        } else {
            promise.resolve("nil");
        }
    }

    @ReactMethod
    public void mobileCountryCode(Promise promise) {
        String mcc = mTelephonyManager.getNetworkOperator();
        if (mcc != null) {
            promise.resolve(mcc);
        } else {
            promise.resolve("nil");
        }
    }

    @ReactMethod
    public void mobileNetworkCode(Promise promise) {
        String mnc = mTelephonyManager.getNetworkOperator();
        if (mnc != null) {
            promise.resolve(mnc);
        } else {
            promise.resolve("nil");
        }
    }

    // return MCC + MNC, e.g. 46697
    @ReactMethod
    public void mobileNetworkOperator(Promise promise) {
        String operator = mTelephonyManager.getNetworkOperator();
        if (operator != null) {
            promise.resolve(operator);
        } else {
            promise.resolve("nil");
        }
    }
}
