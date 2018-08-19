pragma solidity ^0.4.4;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./utils/Control.sol";
//import "./NatanLecture.sol";

/**
 * @title NatanStudent
 */
contract NatanStudent is Control {

    event StudentWhitelisted(address indexed student);
    event StudentBlacklisted(address indexed student);

    struct Student {
        string firstName;
        string lastName;
    }

    mapping(address => bool) public whiteListedStudent;       //mapping white listed student
    mapping(address => bool) public blackListedStudent;       //mapping black listed student

    /**
    * @dev function to whitelist a student
    * @param _studentAdd address of student
    */
    function whiteListStudent(address _studentAdd) external onlyOwner {
        require(_studentAdd != address(0), "Invalid address");
        whiteListedStudent[_studentAdd] = true;

        emit StudentWhitelisted(_studentAdd);
    }

    /**
    * @dev function to blacklist a student
    * @param _studentAdd address of student
    */
    function blackListStudent(address _studentAdd) external onlyOwner {
        require(_studentAdd != address(0), "Invalid address");
        require(whiteListedStudent[_studentAdd] == true, "student is not available");
        whiteListedStudent[_studentAdd] = false;
        blackListedStudent[_studentAdd] = true;

        emit StudentBlacklisted(_studentAdd);
    }

}
