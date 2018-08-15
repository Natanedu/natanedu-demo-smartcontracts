pragma solidity ^0.4.4;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./utils/Control.sol";
import "./NatanLecture.sol";

/**
 * @title NatanStudent
 */
contract NatanStudent is Control, NatanLecture {

    struct Student {
        string firstName;
        string lastName;
    }

    mapping(address => bool) public whiteListed;       //mapping whitelisted student
    mapping(address => bool) public blackListed;       //mapping blacklisted student

    /**
    * @dev function to whitelist a student
    * @param _studentAdd address of student
    */
    function whiteList(address _studentAdd) external onlyOwner {
        require(_studentAdd != address(0), "Invalid address");
        whiteListed[_studentAdd] = true;
    }

    /**
    * @dev function to blacklist a student
    * @param _studentAdd address of student
    */
    function blackList(address _studentAdd) external onlyOwner {
        require(_studentAdd != address(0), "Invalid address");
        require(whiteListed[_studentAdd] == true, "student is not available");
        whiteListed[_studentAdd] = false;
        blackListed[_studentAdd] = true;
    }

}
