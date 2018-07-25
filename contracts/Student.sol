pragma solidity ^0.4.4;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract Student {

    mapping(address => bool) whiteListed;
    mapping(address => bool) blackListed;
    
    constructor() {
    }

    function whiteList(address _studentAdd) public {
        require(_studentAdd != address(0), "Invalid address");
        whiteListed[_studentAdd] = true;
    }

    function blackList(address _studentAdd) public {
        require(_studentAdd != address(0), "Invalid address");
        blackListed[_studentAdd] = true;
    }

}
