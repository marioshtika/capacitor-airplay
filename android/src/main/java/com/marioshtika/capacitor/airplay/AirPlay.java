package com.marioshtika.capacitor.airplay;

public class AirPlay {

    public static final String IOS_ONLY_ERROR = "AirPlay is only available on iOS.";

    public boolean isAvailable() {
        return false;
    }

    public String getUnavailableMessage() {
        return IOS_ONLY_ERROR;
    }
}
