package com.ianlin.RNCarrierInfo;

import android.content.Context;
import android.telephony.TelephonyManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

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
    private ReactApplicationContext context;

    public RNCarrierInfoModule(ReactApplicationContext reactContext) {
        super(reactContext);
        mTelephonyManager = (TelephonyManager) reactContext.getSystemService(Context.TELEPHONY_SERVICE);
        context = reactContext;
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
        String mcc = mTelephonyManager.getNetworkOperator();
        if (mcc != null) {
            promise.resolve(mcc);
        } else {
            promise.reject(E_NO_MOBILE_COUNTRY_CODE, "No mobile country code");
        }
    }

    @ReactMethod
    public void mobileNetworkCode(Promise promise) {
        String mnc = mTelephonyManager.getNetworkOperator();
        if (mnc != null) {
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

    @ReactMethod
    public void mobileTechnology(Promise promise) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo info = cm.getActiveNetworkInfo();
        String mobileTech = "";

        // if (info.getType() == ConnectivityManager.TYPE_WIFI) {
        //     mobileTech = "wifi";
        // }

        if (info != null && info.isConnected()) {
            if (info.getType() == ConnectivityManager.TYPE_MOBILE) {
                int networkType = info.getSubtype();

                switch (networkType) {
                    case TelephonyManager.NETWORK_TYPE_GPRS:
                    case 16: // TelephonyManager.NETWORK_TYPE_GSM:
                    case TelephonyManager.NETWORK_TYPE_EDGE:
                    case TelephonyManager.NETWORK_TYPE_CDMA:
                    case TelephonyManager.NETWORK_TYPE_1xRTT:
                    case TelephonyManager.NETWORK_TYPE_IDEN: // if api<8 : replace by 11
                        mobileTech = "2g";
                    case TelephonyManager.NETWORK_TYPE_UMTS:
                    case TelephonyManager.NETWORK_TYPE_EVDO_0:
                    case TelephonyManager.NETWORK_TYPE_EVDO_A:
                    case TelephonyManager.NETWORK_TYPE_HSDPA:
                    case TelephonyManager.NETWORK_TYPE_HSUPA:
                    case TelephonyManager.NETWORK_TYPE_HSPA:
                    case TelephonyManager.NETWORK_TYPE_EVDO_B: // if api<9 : replace by 14
                    case TelephonyManager.NETWORK_TYPE_EHRPD:  // if api<11 : replace by 12
                    case TelephonyManager.NETWORK_TYPE_HSPAP:  // if api<13 : replace by 15
                    case 17: // TelephonyManager.NETWORK_TYPE_TD_SCDMA:
                        mobileTech = "3g";
                    case TelephonyManager.NETWORK_TYPE_LTE:    // if api<11 : replace by 13
                    case 18: // TelephonyManager.NETWORK_TYPE_IWLAN:
                        mobileTech = "4g";
                    default:
                        mobileTech = "unknown";
                }
            }
        } else {
            mobileTech = "unknown";
        }

        promise.resolve(mobileTech);
    }
}
