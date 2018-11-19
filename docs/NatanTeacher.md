# NatanTeacher (NatanTeacher.sol)

View Source: [contracts/NatanTeacher.sol](../contracts/NatanTeacher.sol)

**↗ Extends: [Control](Control.md)**
**↘ Derived Contracts: [NatanLecture](NatanLecture.md)**

**NatanTeacher**

## Structs
### Teacher

```js
struct Teacher {
 string firstName,
 string lastName,
 string region,
 string topic
}
```

## Contract Members
**Constants & Variables**

```js
mapping(address => bool) public whiteListedTeacher;
mapping(address => bool) public blackListedTeacher;
mapping(address => uint256) public teacherBalance;

```

**Events**

```js
event Transfer(address indexed teacher);
event Whitelisted(address indexed teacher);
event Blacklisted(address indexed teacher);
```

## Functions

- [whiteList(address _teacherAdd)](#whitelist)
- [blackList(address _teacherAdd)](#blacklist)
- [withdraw(address _teacher, uint256 _amount)](#withdraw)

### whiteList

⤾ overrides [NatanStudent.whiteList](NatanStudent.md#whitelist)

function to whitelist a teacher

```js
function whiteList(address _teacherAdd) external nonpayable onlyOwner 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _teacherAdd | address | address of teacher | 

### blackList

⤾ overrides [NatanStudent.blackList](NatanStudent.md#blacklist)

function to blacklist a teacher

```js
function blackList(address _teacherAdd) external nonpayable onlyOwner 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _teacherAdd | address | address of teacher | 

### withdraw

function to withdraw money

```js
function withdraw(address _teacher, uint256 _amount) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _teacher | address | teacher address | 
| _amount | uint256 | amount to transfer in Wei | 

## Contracts

* [Control](Control.md)
* [Migrations](Migrations.md)
* [NatanAdmin](NatanAdmin.md)
* [NatanLecture](NatanLecture.md)
* [NatanStudent](NatanStudent.md)
* [NatanTeacher](NatanTeacher.md)
* [SafeMath](SafeMath.md)
* [Validator](Validator.md)
