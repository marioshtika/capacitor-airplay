package com.marioshtika.capacitor.airplay;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "AirPlay")
public class AirPlayPlugin extends Plugin {

    private final AirPlay implementation = new AirPlay();

    @PluginMethod
    public void show(PluginCall call) {
        call.reject(implementation.getUnavailableMessage());
    }

    @PluginMethod
    public void isAvailable(PluginCall call) {
        JSObject ret = new JSObject();
        ret.put("available", implementation.isAvailable());
        call.resolve(ret);
    }
}
