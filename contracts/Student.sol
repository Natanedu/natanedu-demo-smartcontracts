pragma solidity ^0.4.4;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Student {

    mapping(address => bool) whiteListed;
    mapping(address => bool) blackListed;
    
    constructor() {
    }

    function whiteList(address _studentAdd) public {
        whiteListed[_studentAdd] = true;
    }

    function blackList(address _studentAdd) public {
        blackListed[_studentAdd] = true;
    }

}
