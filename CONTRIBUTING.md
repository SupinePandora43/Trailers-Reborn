- [For Developers](#for-developers)
	- [`Trailers`](#trailers)
		- [`Init`](#init)
			- [`vehtable`](#vehtable)
				- [`ent`](#ent)
				- [`vehtype`](#vehtype)
				- [`outputPos`](#outputpos)
				- [`inputPos`](#inputpos)
				- [`outputType`](#outputtype)
				- [`inputType`](#inputtype)
			- [`github`](#github)
			- [Connection Types](#connection-types)

# For Developers

## `Trailers`

### `Init`

#### `vehtable`

##### `ent`

**[`Entity`](https://wiki.facepunch.com/gmod/Entity)**

simfphys vehicle entity ( `ent` inside of `OnSpawn(ent)` function)

##### `vehtype`

Only 3 different types of vehicles (case non-sensetive)

* **Truck** ( [ `outputPos` ](#outputpos) )
* **Dolly** ( [ `outputPos` ](#outputpos) , [ `inputPos` ](#inputpos) )
* **Trailer** ( [ `inputPos` ](#inputpos) )

##### `outputPos`

**[`Vector`](https://wiki.facepunch.com/gmod/Vector)**

Truck's/dolly's connector point

###### *still useable with trailers*

##### `inputPos`

**[`Vector`](https://wiki.facepunch.com/gmod/Vector)**

Dolly's/trailer's connector point

###### *not useable with trucks*

##### `outputType`

**[`string`](https://wiki.facepunch.com/gmod/string)**

[Connection Types](#connection-types)

##### `inputType`

**[`string`](https://wiki.facepunch.com/gmod/string)**

[Connection Types](#connection-types)

#### `github`

**[`boolean`](https://wiki.facepunch.com/gmod/boolean)**

use Trailers-Base repository to get info about vehicle

#### Connection Types

* `axis`
* `joint`

`AdvBallSocket` is always used, it just to prevent connecting big trailers to small passenger cars
