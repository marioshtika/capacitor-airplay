import { WebPlugin } from '@capacitor/core';

import type { AirPlayPlugin } from './definitions';

const WEB_UNAVAILABLE_ERROR = 'AirPlay is not available on Web. AirPlay is only available on iOS.';

export class AirPlayWeb extends WebPlugin implements AirPlayPlugin {
  async show(): Promise<void> {
    throw new Error(WEB_UNAVAILABLE_ERROR);
  }

  async isAvailable(): Promise<{ available: boolean }> {
    return { available: false };
  }
}
