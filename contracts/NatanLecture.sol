pragma solidity ^0.4.4;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./NatanStudent.sol";
import "./NatanTeacher.sol";

/**
 * @title NatanLecture
 */
contract NatanLecture is NatanStudent, NatanTeacher {

    using SafeMath for uint256;

    uint256 lecturesId = 0; 

    event Transfer(address indexed teacher);    

    mapping(uint => mapping(address => bool)) paidLecture;     //mapping lecture id to address who payed for it
    mapping(uint => bytes) recordedLecture;                     //mapping lecture id to it's IPFS hash
    mapping(uint => mapping(address => bool)) accessLecture;    //mapping lecture id to address who have access to it

    function generateLectureId() public returns (uint256) {
        lecturesId = lecturesId.add(1);
        return lecturesId;
    }

    /**
     * @dev function to pay for lecture
     * @param _lectureId id of lecture
     * @param _lecturePrice price of lecture
     * @param _teacher address of the lecture's teacher
     */
    function payLecture(uint _lectureId, uint _lecturePrice, address _teacher) public payable {
        require(msg.value == _lecturePrice, "insufficient amount of ether for lecture price");
        require(_teacher != address(0), "invalid teacher address");
        require(whiteListedTeacher[_teacher] == true, "teacher not found");

        paidLecture[_lectureId][msg.sender] = true;
        teacherBalance[_teacher] += msg.value;
    }

    /**
     * @dev function to save IPFS hash of a recorded lecture
     * @param _lectureId id of lecture
     * @param _ipfsHash IPFS hash
     */
    function saveRecordedLecture(uint _lectureId, bytes _ipfsHash) internal {
        recordedLecture[_lectureId] = _ipfsHash;
        //restrict lecture access
        accessLecture[_lectureId][msg.sender] = true;
    }

    /**
     * @dev function to get IPFS hash of a recorded lecture
     * @param _lectureId id of lecture
     * @return IPFS hash
     */
    function getRecordedLecture(uint _lectureId) internal view returns(bytes) {
        require(accessLecture[_lectureId][msg.sender], "no permission to access this lecture");
        return recordedLecture[_lectureId];
    }

    /**
     * @dev function to tranfer money to specified teacher address
     * @param _amount amount to transfer in Wei
     */
    function transfer(uint _amount) public {
        require(whiteListedTeacher[msg.sender] == true, "Teacher not authorized");
        require(teacherBalance[msg.sender] >= _amount, "Teacher balance is insufficient");

        withdraw(msg.sender, _amount);
    }

}
