pragma solidity ^0.4.4;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./Control.sol";
import "./Lecture.sol";

contract Student is Control, Lecture {

    struct structTeacher {
        string firstName;
        string lastName;
    }

    mapping(address => bool) whiteListed;
    mapping(address => bool) blackListed;
    
    constructor() {
    }

    /**
    * @dev function to whitelist a student
    * @param _studentAdd address of student
    */
    function whiteList(address _studentAdd) public onlyOwner {
        require(_studentAdd != address(0), "Invalid address");
        whiteListed[_studentAdd] = true;
    }

    /**
    * @dev function to blacklist a student
    * @param _studentAdd address of student
    */
    function blackList(address _studentAdd) public onlyOwner {
        require(_studentAdd != address(0), "Invalid address");
        blackListed[_studentAdd] = true;
    }

}
