export interface AirPlayPlugin {
  /**
   * Opens Apple's native AirPlay route picker on iOS.
   */
  show(): Promise<void>;

  /**
   * Returns whether the native AirPlay route picker can be opened on the current platform.
   */
  isAvailable(): Promise<{ available: boolean }>;
}
