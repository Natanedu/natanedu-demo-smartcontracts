# NatanAdmin (NatanAdmin.sol)

View Source: [contracts/NatanAdmin.sol](../contracts/NatanAdmin.sol)

**↗ Extends: [Control](Control.md)**

**NatanAdmin**

The NatanAdmin contract has all the functions related to the admins of Natanedu platform

## Functions

- [addAdmin(address _newAllowed)](#addadmin)
- [removeAdmin(address _toRemove)](#removeadmin)

### addAdmin

add new admin

```js
function addAdmin(address _newAllowed) external nonpayable onlyOwner 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _newAllowed | address | address of the new admin | 

### removeAdmin

remove admin

```js
function removeAdmin(address _toRemove) external nonpayable onlyOwner 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _toRemove | address | owner that will be removed | 

## Contracts

* [Control](Control.md)
* [Migrations](Migrations.md)
* [NatanAdmin](NatanAdmin.md)
* [NatanLecture](NatanLecture.md)
* [NatanStudent](NatanStudent.md)
* [NatanTeacher](NatanTeacher.md)
* [SafeMath](SafeMath.md)
* [Validator](Validator.md)
