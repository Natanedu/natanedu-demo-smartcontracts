pragma solidity ^0.4.4;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./utils/Control.sol";

/**
 * @title NatanStudent
 */
contract NatanStudent is Control {

    event StudentRegistered(address indexed student);
    event StudentWhitelisted(address indexed student);
    event StudentBlacklisted(address indexed student);

    struct Student {
        string firstName;
        string lastName;
    }

    //list of students
    mapping(address => Student) public students; 

    /** 
     * listed students:
     * 1 = blacklisted
     * 2 = in process
     * 3 = whitelisted  
     */ 
    mapping(address => uint) public listedStudents;

    function registerStudent(address _add, string _name, string _lastName) public {
        require(_add != address(0), "Invalid address");
        require(listedStudents[_add] == 0, "Student already registered");

        //add student
        students[_add] = Student(_name, _lastName);
        //mark student listing in progress
        listedStudents[_add] = 2;

        emit StudentRegistered(_add);
    }

    /**
    * @dev function to whitelist a student
    * @param _studentAdd address of student
    */
    function whiteListStudent(address _studentAdd) external onlyOwner {
        require(_studentAdd != address(0), "Invalid address");
        require(listedStudents[_studentAdd] == 2, "Student not found!");

        listedStudents[_studentAdd] = 3;

        emit StudentWhitelisted(_studentAdd);
    }

    /**
    * @dev function to blacklist a student
    * @param _studentAdd address of student
    */
    function blackListStudent(address _studentAdd) external onlyOwner {
        require(_studentAdd != address(0), "Invalid address");
        require((listedStudents[_studentAdd] == 3) || (listedStudents[_studentAdd] == 2), "student is not available");
        
        listedStudents[_studentAdd] = 1;

        emit StudentBlacklisted(_studentAdd);
    }

}
