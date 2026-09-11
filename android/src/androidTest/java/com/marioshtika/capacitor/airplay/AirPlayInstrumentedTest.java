package com.marioshtika.capacitor.airplay;

import static org.junit.Assert.assertNotNull;

import android.content.Context;
import androidx.test.ext.junit.runners.AndroidJUnit4;
import androidx.test.platform.app.InstrumentationRegistry;
import org.junit.Test;
import org.junit.runner.RunWith;

@RunWith(AndroidJUnit4.class)
public class AirPlayInstrumentedTest {

    @Test
    public void instrumentationContext_isAvailable() {
        Context appContext = InstrumentationRegistry.getInstrumentation().getContext();

        assertNotNull(appContext);
    }
}
