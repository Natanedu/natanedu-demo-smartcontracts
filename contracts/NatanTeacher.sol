pragma solidity ^0.4.4;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./utils/Control.sol";
//import "./NatanLecture.sol";

/**
 * @title NatanTeacher
 */
contract NatanTeacher is Control {

    using SafeMath for uint256;

    event Transfer(address indexed teacher);

    struct Teacher {
        string firstName;
        string lastName;
        string region; 
        string topic;
    }

    mapping(address => bool) public whiteListedTeacher;       //mappping of white listed teachers
    mapping(address => bool) public blackListedTeacher;       //mapping of black listed teachers
    mapping(address => uint) public teacherBalance;    //teacher balance  
    
    /**
    * @dev function to whitelist a teacher
    * @param _teacherAdd address of teacher
    */
    function whiteList(address _teacherAdd) external onlyOwner {
        require(_teacherAdd != address(0), "Invalid address");
        whiteListedTeacher[_teacherAdd] = true;
    }

    /**
    * @dev function to blacklist a teacher
    * @param _teacherAdd address of teacher
    */
    function blackList(address _teacherAdd) external onlyOwner {
        require(_teacherAdd != address(0), "Invalid address");
        require(whiteListedTeacher[_teacherAdd] == true, "Teacher is not available");
        whiteListedTeacher[_teacherAdd] = false;
        blackListedTeacher[_teacherAdd] = true;
    }

    /**
     * @dev function to withdraw money
     * @param _teacher teacher address
     * @param _amount amount to transfer in Wei
     */
    function withdraw(address _teacher, uint _amount) internal {
        _teacher.transfer(_amount);
        teacherBalance[_teacher] = teacherBalance[_teacher].sub(_amount);
        emit Transfer(_teacher);
    }

}
