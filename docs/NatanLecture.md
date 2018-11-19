# NatanLecture (NatanLecture.sol)

View Source: [contracts/NatanLecture.sol](../contracts/NatanLecture.sol)

**↗ Extends: [NatanStudent](NatanStudent.md), [NatanTeacher](NatanTeacher.md)**

**NatanLecture**

## Contract Members
**Constants & Variables**

```js
uint256 internal lecturesId;
mapping(uint256 => mapping(address => bool)) internal paidLecture;
mapping(uint256 => bytes) internal recordedLecture;
mapping(uint256 => mapping(address => bool)) internal accessLecture;

```

**Events**

```js
event Transfer(address indexed teacher);
```

## Functions

- [generateLectureId()](#generatelectureid)
- [payLecture(uint256 _lectureId, uint256 _lecturePrice, address _teacher)](#paylecture)
- [saveRecordedLecture(uint256 _lectureId, bytes _ipfsHash)](#saverecordedlecture)
- [getRecordedLecture(uint256 _lectureId)](#getrecordedlecture)
- [transfer(uint256 _amount)](#transfer)

### generateLectureId

```js
function generateLectureId() public nonpayable
returns(uint256)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### payLecture

function to pay for lecture

```js
function payLecture(uint256 _lectureId, uint256 _lecturePrice, address _teacher) public payable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _lectureId | uint256 | id of lecture | 
| _lecturePrice | uint256 | price of lecture | 
| _teacher | address | address of the lecture's teacher | 

### saveRecordedLecture

function to save IPFS hash of a recorded lecture

```js
function saveRecordedLecture(uint256 _lectureId, bytes _ipfsHash) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _lectureId | uint256 | id of lecture | 
| _ipfsHash | bytes | IPFS hash | 

### getRecordedLecture

function to get IPFS hash of a recorded lecture

```js
function getRecordedLecture(uint256 _lectureId) internal view
returns(bytes)
```

**Returns**

IPFS hash

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _lectureId | uint256 | id of lecture | 

### transfer

function to tranfer money to specified teacher address

```js
function transfer(uint256 _amount) public nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
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
