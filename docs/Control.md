# Control (Control.sol)

View Source: [contracts/utils/Control.sol](../contracts/utils/Control.sol)

**↘ Derived Contracts: [NatanAdmin](NatanAdmin.md), [NatanStudent](NatanStudent.md), [NatanTeacher](NatanTeacher.md)**

**Control**

The controle contract has multiple owners addresses, and provides basic authorization 
control functions, this simplifies the implementation of "user permissions".

## Contract Members
**Constants & Variables**

```js
mapping(address => bool) public owners;

```

**Events**

```js
event OwnershipRenounced(address indexed previousOwner);
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

## Modifiers

- [onlyOwner](#onlyowner)

### onlyOwner

Throws if called by any account other than the owner.

```js
modifier onlyOwner() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

## Functions

- [renounceOwnership()](#renounceownership)

### renounceOwnership

Allows the current owner to relinquish control of the contract.

```js
function renounceOwnership() external nonpayable onlyOwner 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

## Contracts

* [Control](Control.md)
* [Migrations](Migrations.md)
* [NatanAdmin](NatanAdmin.md)
* [NatanLecture](NatanLecture.md)
* [NatanStudent](NatanStudent.md)
* [NatanTeacher](NatanTeacher.md)
* [SafeMath](SafeMath.md)
* [Validator](Validator.md)
