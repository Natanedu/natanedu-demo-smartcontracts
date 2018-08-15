pragma solidity ^0.4.4;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./utils/Control.sol";
import "./NatanLecture.sol";

/**
 * @title NatanTeacher
 */
contract NatanTeacher is Control, NatanLecture {

    struct Teacher {
        string firstName;
        string lastName;
        string region; 
        string topic;
    }

    mapping(address => bool) whiteListed;       //mappping of whitelised teachers
    mapping(address => bool) blackListed;       //mapping of blacklisted teachers

    event Transfer(address indexed teacher);
    
    /**
    * @dev function to whitelist a teacher
    * @param _teacherAdd address of teacher
    */
    function whiteList(address _teacherAdd) public onlyOwner {
        require(_teacherAdd != address(0), "Invalid address");
        whiteListed[_teacherAdd] = true;
    }

    /**
    * @dev function to blacklist a teacher
    * @param _teacherAdd address of teacher
    */
    function blackList(address _teacherAdd) public onlyOwner {
        require(_teacherAdd != address(0), "Invalid address");
        blackListed[_teacherAdd] = true;
    }

    function withdraw(uint _amount) private {
        require(whiteListed[msg.sender] == true, "Teacher not authorized");
        this.transfer(msg.sender, _amount);
        emit Transfer(msg.sender);
    }

}
