pragma solidity ^0.4.4;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./utils/Control.sol";

/**
 * @title NatanTeacher
 */
contract NatanTeacher is Control {

    using SafeMath for uint256;

    event Transfer(address indexed teacher);
    event TeacherWhitelisted(address indexed teacher);
    event TeacherBlacklisted(address indexed teacher);

    struct Teacher {
        string firstName;
        string lastName;
        string region; 
        string topic;
    }

    //List of teachers
    mapping(address => Teacher) public teachers; 

    /** 
     * Listed teachers:
     * 1 = blacklisted
     * 2 = in process
     * 3 = whitelisted  
     */ 
    mapping(address => uint) public listedTeachers;      

    //Teacher balance
    mapping(address => uint) public teacherBalance;             
    
    /**
     * @dev function to whitelist a teacher
     * @param _teacherAdd address of teacher
     */
    function whiteListTeacher(address _teacherAdd) external onlyOwner {
        //require valid address
        require(_teacherAdd != address(0), "Invalid address");
        require(listedTeachers[_teacherAdd] == 2, "Teacher not found!");
        
        //whitelist teacher
        listedTeachers[_teacherAdd] = 3;

        emit TeacherWhitelisted(_teacherAdd);
    }

    /**
     * @dev function to blacklist a teacher
     * @param _teacherAdd address of teacher
     */
    function blackListTeacher(address _teacherAdd) external onlyOwner {
        //require valid address
        require(_teacherAdd != address(0), "Invalid address");
        //require that teacher is already whitelisted or in process
        require((listedTeachers[_teacherAdd] == 3) || (listedTeachers[_teacherAdd] == 2), "Teacher is not available");
        
        //blacklist teacher
        listedTeachers[_teacherAdd] = 1;

        emit TeacherBlacklisted(_teacherAdd);
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
