# For Developers

# Adding Support to vehicle

you need to append vehicle's spawnlist

you need add

```lua
FLEX = {
	Trailers = {
		
	}
}
```
should look like
```lua
list.Set("simfphys_vehicles", "myvehicle", {
	Name = "My Car",
	Model = "models/path/to/model.mdl",
	Category = "My Category",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 0,
	FLEX = {
		Trailers = {
			-- #goto FLEX.Trailers params
		}
	},
	Members = {
		OnSpawn = function(ent)
			-- if you making trailer
			-- you need `ent:Lock()` here
		end,
		-- car configuration stuff here
	}
})
```

# FLEX.Trailers params

`inputPos`: Vector - input position of trailer/dolly

`inputType`: string | any - type of input ([ConnectionTypes](#ConnectionTypes))

`outputPos`: Vector - output position of truck/dolly

`outputType`: string | any - type of output ([ConnectionTypes](#ConnectionTypes))

# ConnectionTypes

**NOTE**: types can be of any type // more detailed info

`"axis"` for 

![pic](https://moscowteslaclub.ru/upload/resize_cache/iblock/7e3/1266_715_2/7e3c6ca47f35796b90b4cf44cbaa3c4e.jpg)

`"ballsocket"` for

![pic](https://hips.hearstapps.com/pop.h-cdn.co/assets/16/38/980x652/gallery-1474470091-pmx100116-utilitytrailers07.jpg?resize=480:*)

# Low Level API

Can be used to directly initializate trailer support,

`Trailers.Init(ventitytable)`

it requires a table, exactly like [FLEX.Trailers params](#FLEX.Trailers params), **BUT** with `ent` key, equal to target simfphys vehicle
