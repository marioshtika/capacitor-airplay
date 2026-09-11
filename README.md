# capacitor-airplay

A Capacitor plugin that opens Apple's native iOS AirPlay picker from JavaScript or TypeScript.

## Compatibility

| Plugin version | Capacitor compatibility | Maintained |
| -------------- | ----------------------- | ---------- |
| v8.\*.\*       | v8.\*.\*                | ✅         |

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

## Availability check

```typescript
const { available } = await AirPlay.isAvailable();

if (available) {
  await AirPlay.show();
}
```

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
