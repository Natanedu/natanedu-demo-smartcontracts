pragma solidity ^0.4.4;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";

/**
 * @title NatanLecture
 */
contract NatanLecture {

    using SafeMath for uint256;

    uint256 lecturesId = 0;     

    mapping(uint => mapping(address => bool)) payedLecture;     //mapping lecture id to address who payed for it
    mapping(uint => bytes) recordedLecture;                     //mapping lecture id to it's IPFS hash
    mapping(uint => mapping(address => bool)) accessLecture;    //mapping lecture id to address who have access to it
    
    mapping (address => uint) teacherBalance;

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
    function payLecture(uint _lectureId, uint _lecturePrice, address _teacher) external payable {
        require(msg.value == _lecturePrice, "insufficient amount of ether for lecture price");
        payedLecture[_lectureId][msg.sender] = true;
        teacherBalance[_teacher] += msg.value;
    }

    /**
     * @dev function to save IPFS hash of a recorded lecture
     * @param _lectureId id of lecture
     * @param _ipfsHash IPFS hash
     */
    function saveRecordedLecture(uint _lectureId, bytes _ipfsHash) public {
        recordedLecture[_lectureId] = _ipfsHash;
        //restrict lecture access
        accessLecture[_lectureId][msg.sender] = true;
    }

    /**
     * @dev function to get IPFS hash of a recorded lecture
     * @param _lectureId id of lecture
     * @return IPFS hash
     */
    function getRecordedLecture(uint _lectureId) public view returns(bytes) {
        require(accessLecture[_lectureId][msg.sender], "no permission to access this lecture");
        return recordedLecture[_lectureId];
    }

    /**
     * @dev function to tranfer money to specified teacher address
     * @param _teacher teacher's address
     * @param _amount amount to transfer in Wei
     */
    function transfer(address _teacher, uint _amount) external {
        require(_teacher != address(0), "invalid address");
        require(teacherBalance[_teacher] >= _amount, "Teacher balance is insufficient");
        _teacher.transfer(_amount);
        teacherBalance[msg.sender] = teacherBalance[msg.sender].sub(_amount);
    }

}
