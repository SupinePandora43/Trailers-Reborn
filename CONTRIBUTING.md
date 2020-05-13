- [For Developers](#for-developers)
	- [Concepts](#concepts)
		- [`trailers_reborn` . `Init`](#trailers_reborn--init)
			- [`vehtable`](#vehtable)
				- [`ent`](#ent)
				- [`vehtype`](#vehtype)
				- [`outputPos`](#outputpos)
				- [`inputPos`](#inputpos)
				- [`outputType`](#outputtype)
				- [`inputType`](#inputtype)
			- [Connection Types](#connection-types)

# For Developers

## Concepts

### `trailers_reborn` . `Init`

#### `vehtable`

##### `ent`

simfphys vehicle entity ( `ent` inside of `OnSpawn(ent)` function)

##### `vehtype`

Only 3 different types of vehicles (case non-sensetive)

* **Truck** ( [ `outputPos` ](#outputpos) )
* **Dolly** ( [ `outputPos` ](#outputpos) , [ `inputPos` ](#inputpos) )
* **Trailer** ( [ `inputPos` ](#inputpos) )

##### `outputPos`

Truck's/dolly's connector point

###### still useable with trailers

##### `inputPos`

Dolly's/trailer's connector point

###### not useable with trucks

##### `outputType`

[Connection Types](#connection-types)

##### `inputType`

[Connection Types](#connection-types)

#### Connection Types

* `axis`
* `joint`
