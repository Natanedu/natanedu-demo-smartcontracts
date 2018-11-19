# Migrations.sol

View Source: [contracts/Migrations.sol](../contracts/Migrations.sol)

**Migrations**

## Contract Members
**Constants & Variables**

```js
address public owner;
uint256 public last_completed_migration;

```

## Modifiers

- [restricted](#restricted)

### restricted

```js
modifier restricted() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

## Functions

- [setCompleted(uint256 completed)](#setcompleted)
- [upgrade(address new_address)](#upgrade)

### setCompleted

```js
function setCompleted(uint256 completed) public nonpayable restricted 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| completed | uint256 |  | 

### upgrade

```js
function upgrade(address new_address) public nonpayable restricted 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| new_address | address |  | 

## Contracts

* [Control](Control.md)
* [Migrations](Migrations.md)
* [NatanAdmin](NatanAdmin.md)
* [NatanLecture](NatanLecture.md)
* [NatanStudent](NatanStudent.md)
* [NatanTeacher](NatanTeacher.md)
* [SafeMath](SafeMath.md)
* [Validator](Validator.md)
