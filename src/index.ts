import { registerPlugin } from '@capacitor/core';

import type { AirPlayPlugin } from './definitions';

const AirPlay = registerPlugin<AirPlayPlugin>('AirPlay', {
  web: () => import('./web').then((m) => new m.AirPlayWeb()),
});

export * from './definitions';
export { AirPlay };
