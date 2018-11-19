# NatanStudent (NatanStudent.sol)

View Source: [contracts/NatanStudent.sol](../contracts/NatanStudent.sol)

**↗ Extends: [Control](Control.md)**
**↘ Derived Contracts: [NatanLecture](NatanLecture.md)**

**NatanStudent**

## Structs
### Student

```js
struct Student {
 string firstName,
 string lastName
}
```

## Contract Members
**Constants & Variables**

```js
mapping(address => bool) public whiteListedStudent;
mapping(address => bool) public blackListedStudent;

```

**Events**

```js
event Whitelisted(address indexed student);
event Blacklisted(address indexed student);
```

## Functions

- [whiteList(address _studentAdd)](#whitelist)
- [blackList(address _studentAdd)](#blacklist)

### whiteList

⤿ Overridden Implementation(s): [NatanTeacher.whiteList](NatanTeacher.md#whitelist)

function to whitelist a student

```js
function whiteList(address _studentAdd) external nonpayable onlyOwner 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _studentAdd | address | address of student | 

### blackList

⤿ Overridden Implementation(s): [NatanTeacher.blackList](NatanTeacher.md#blacklist)

function to blacklist a student

```js
function blackList(address _studentAdd) external nonpayable onlyOwner 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _studentAdd | address | address of student | 

## Contracts

* [Control](Control.md)
* [Migrations](Migrations.md)
* [NatanAdmin](NatanAdmin.md)
* [NatanLecture](NatanLecture.md)
* [NatanStudent](NatanStudent.md)
* [NatanTeacher](NatanTeacher.md)
* [SafeMath](SafeMath.md)
* [Validator](Validator.md)
