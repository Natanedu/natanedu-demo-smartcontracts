# Validator.sol

View Source: [contracts/utils/Validator.sol](../contracts/utils/Validator.sol)

**Validator**

## Contract Members
**Constants & Variables**

```js
mapping(uint256 => bool) internal usedNonces;

```

## Functions

- [prefixed(bytes32 hash)](#prefixed)
- [isSigned(uint256 _lectureId, uint256 nonce, bytes sig)](#issigned)
- [recoverSigner(bytes32 message, bytes sig)](#recoversigner)
- [splitSignature(bytes sig)](#splitsignature)

### prefixed

```js
function prefixed(bytes32 hash) internal pure
returns(bytes32)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| hash | bytes32 |  | 

### isSigned

Check if an address signed a message

```js
function isSigned(uint256 _lectureId, uint256 nonce, bytes sig) public nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _lectureId | uint256 | lecture id | 
| nonce | uint256 | random number to protect against replay attacks | 
| sig | bytes | the signed hash | 

### recoverSigner

function to get the address of the signer who signed the message

```js
function recoverSigner(bytes32 message, bytes sig) internal pure
returns(address)
```

**Returns**

signer address

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| message | bytes32 | the signed message | 
| sig | bytes | the signature | 

### splitSignature

Function to split the signature

```js
function splitSignature(bytes sig) internal pure
returns(uint8, bytes32, bytes32)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| sig | bytes | the signature | 

## Contracts

* [Control](Control.md)
* [Migrations](Migrations.md)
* [NatanAdmin](NatanAdmin.md)
* [NatanLecture](NatanLecture.md)
* [NatanStudent](NatanStudent.md)
* [NatanTeacher](NatanTeacher.md)
* [SafeMath](SafeMath.md)
* [Validator](Validator.md)
