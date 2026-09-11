# capacitor-airplay

A production-ready Capacitor 8 plugin that opens Apple's native iOS AirPlay picker from JavaScript or TypeScript.

```typescript
import { AirPlay } from 'capacitor-airplay';

await AirPlay.show();
```

## What this plugin does

- Opens Apple's native AirPlay/media route picker on iOS
- Lets your app keep full control of the visible UI
- Exposes a tiny function-based API for Capacitor apps

## What this plugin does not do

- It does **not** create a visible AirPlay button for your app
- It does **not** require you to add a native iOS view component
- It does **not** implement AirPlay discovery, custom device scanning, or custom route-selection UI
- It does **not** support Android or Web in this first version

Your application creates the visible button in Ionic, Angular, React, Vue, or plain HTML. The plugin only opens the native picker when you call `show()`.

## Install

```bash
npm install capacitor-airplay
npx cap sync
```

## Basic usage

```typescript
import { AirPlay } from 'capacitor-airplay';

await AirPlay.show();
```

## Ionic example

```html
<ion-button (click)="openAirPlay()">
  AirPlay
</ion-button>
```

```typescript
import { AirPlay } from 'capacitor-airplay';

async openAirPlay() {
  await AirPlay.show();
}
```

## Availability check

```typescript
const { available } = await AirPlay.isAvailable();

if (available) {
  await AirPlay.show();
}
```

## Platform behavior

### iOS

- `isAvailable()` returns `{ available: true }` when the plugin has an active iOS view it can present from
- `show()` runs on the main thread
- `show()` internally creates a temporary, effectively invisible `AVRoutePickerView`
- The temporary native view is attached only long enough to trigger Apple's built-in route picker and is then cleaned up
- No visible native AirPlay button is added to your app UI

> Apple does not provide a separate public modal API for opening the AirPlay picker without a route picker view. This plugin uses `AVRoutePickerView` internally and keeps that implementation detail hidden from JavaScript so the developer experience remains `await AirPlay.show()`.

### Android

- `isAvailable()` returns `{ available: false }`
- `show()` rejects with `AirPlay is only available on iOS.`

### Web

- `isAvailable()` returns `{ available: false }`
- `show()` rejects with an error explaining that AirPlay is unavailable on Web and only supported on iOS by this plugin

## API

<docgen-index>

* [`show()`](#show)
* [`isAvailable()`](#isavailable)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### show()

```typescript
show() => Promise<void>
```

Opens Apple's native AirPlay route picker on iOS.

--------------------


### isAvailable()

```typescript
isAvailable() => Promise<{ available: boolean; }>
```

Returns whether the native AirPlay route picker can be opened on the current platform.

**Returns:** <code>Promise&lt;{ available: boolean; }&gt;</code>

--------------------

</docgen-api>
