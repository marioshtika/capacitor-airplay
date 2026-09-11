package com.marioshtika.capacitor.airplay;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

import org.junit.Test;

public class AirPlayTest {

    @Test
    public void isAvailable_returnsFalseOnAndroid() {
        AirPlay implementation = new AirPlay();

        assertFalse(implementation.isAvailable());
    }

    @Test
    public void unavailableMessage_isClear() {
        AirPlay implementation = new AirPlay();

        assertEquals("AirPlay is only available on iOS.", implementation.getUnavailableMessage());
    }
}
