pragma solidity ^0.5.0;


import "./utils/SafeMath.sol";
import "./utils/Control.sol";

/** @title NatanTeacher */
contract NatanTeacher is Control {

    using SafeMath for uint256;

    ///@notice teacher structure
    struct Teacher {
        string firstName;
        string lastName;
        string region; 
        string topic;
    }

    ///@notice List of teachers
    mapping(address => Teacher) public teachers; 

    ///@notice list of listed teachers: 1=blacklisted, 2=in process, 3=whitelisted
    mapping(address => uint) public listedTeachers;      

    ///@notice list of teacher's balance
    mapping(address => uint256) public teacherBalance; 

    event Transfer(address indexed teacher);
    event TeacherWhitelisted(address indexed teacher);
    event TeacherBlacklisted(address indexed teacher);
    event RegisteredTeacher(address indexed teacher);

    /**
     * @dev register teacher
     * @param _add teacher address
     * @param _name teacher name
     * @param _lastName teacher last name
     * @param _region teacher region
     * @param _topic teacher topic
     */
    function registerTeacher(address _add, string memory _name, string memory _lastName, string memory _region, string memory _topic) public {
        require(_add != address(0), "Invalid address");
        require(listedTeachers[_add] == 0, "Teacher already registered");

        //add teacher
        teachers[_add] = Teacher(_name, _lastName, _region, _topic);
        //mark teacher listing in progress
        listedTeachers[_add] = 2;

        emit RegisteredTeacher(_add);
    }            
    
    /**
     * @dev whitelist a teacher
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
     * @dev blacklist a teacher
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
     * @dev withdraw money
     * @param _teacher teacher address
     * @param _amount amount to transfer in Wei
     */
    function withdraw(address payable _teacher, uint _amount) internal {
        _teacher.transfer(_amount);
        teacherBalance[_teacher] = teacherBalance[_teacher].sub(_amount);

        emit Transfer(_teacher);
    }

}
