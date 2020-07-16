[trailers-reborn](../README.md) › [Globals](../globals.md) › ["tr/sv_init"](_tr_sv_init_.md)

# Module: "tr/sv_init"

## Index

### Namespaces

* [Trailers](_tr_sv_init_.trailers.md)
* [debug](_tr_sv_init_.debug.md)

### Enumerations

* [SIZES](../enums/_tr_sv_init_.sizes.md)

### Variables

* [files](_tr_sv_init_.md#const-files)

### Functions

* [GetConnectable](_tr_sv_init_.md#getconnectable)
* [IsConnectable](_tr_sv_init_.md#isconnectable)
* [IsConnectableTypes](_tr_sv_init_.md#isconnectabletypes)
* [RestartSystemHandler](_tr_sv_init_.md#restartsystemhandler)
* [findVEntity](_tr_sv_init_.md#findventity)
* [getNext](_tr_sv_init_.md#getnext)
* [getwhole](_tr_sv_init_.md#getwhole)
* [valid](_tr_sv_init_.md#valid)

## Variables

### `Const` files

• **files**: *table* = file.Find("tr/systems/*", "LUA")[0]

Defined in tr/sv_init.ts:114

## Functions

###  GetConnectable

▸ **GetConnectable**(`this`: void, `ventity`: VEntity): *undefined | object*

Defined in tr/sv_init.ts:45

**Parameters:**

Name | Type |
------ | ------ |
`this` | void |
`ventity` | VEntity |

**Returns:** *undefined | object*

___

###  IsConnectable

▸ **IsConnectable**(`this`: void, `vent1`: VEntity, `vent2`: VEntity): *undefined | false | true*

Defined in tr/sv_init.ts:40

**Parameters:**

Name | Type |
------ | ------ |
`this` | void |
`vent1` | VEntity |
`vent2` | VEntity |

**Returns:** *undefined | false | true*

___

###  IsConnectableTypes

▸ **IsConnectableTypes**(`this`: void, `ctype1?`: undefined | string, `ctype2?`: undefined | string): *boolean*

Defined in tr/sv_init.ts:34

**Parameters:**

Name | Type |
------ | ------ |
`this` | void |
`ctype1?` | undefined &#124; string |
`ctype2?` | undefined &#124; string |

**Returns:** *boolean*

___

###  RestartSystemHandler

▸ **RestartSystemHandler**(`this`: void): *void*

Defined in tr/sv_init.ts:130

**Parameters:**

Name | Type |
------ | ------ |
`this` | void |

**Returns:** *void*

___

###  findVEntity

▸ **findVEntity**(`this`: void, `entity`: Entity): *undefined | object*

Defined in tr/sv_init.ts:12

**Parameters:**

Name | Type |
------ | ------ |
`this` | void |
`entity` | Entity |

**Returns:** *undefined | object*

___

###  getNext

▸ **getNext**(`this`: void, `ventity`: VEntity | undefined): *undefined | object*

Defined in tr/sv_init.ts:19

**Parameters:**

Name | Type |
------ | ------ |
`this` | void |
`ventity` | VEntity &#124; undefined |

**Returns:** *undefined | object*

___

###  getwhole

▸ **getwhole**(`this`: void, `ventity`: VEntity): *object[]*

Defined in tr/sv_init.ts:22

**Parameters:**

Name | Type |
------ | ------ |
`this` | void |
`ventity` | VEntity |

**Returns:** *object[]*

___

###  valid

▸ **valid**(`this`: void, `callbackfn?`: undefined | function): *void*

Defined in tr/sv_init.ts:3

**Parameters:**

Name | Type |
------ | ------ |
`this` | void |
`callbackfn?` | undefined &#124; function |

**Returns:** *void*
