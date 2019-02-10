pragma solidity ^0.5.0;

import "./utils/SafeMath.sol";
import "./NatanStudent.sol";
import "./NatanTeacher.sol";

/** @title NatanLecture */
contract NatanLecture is NatanStudent, NatanTeacher {

    using SafeMath for uint256;

    ///@notice lecture id counter
    uint256 public lecturesId = 0; 

    ///@notice list of paid lectures
    mapping(uint => mapping(address => bool)) paidLecture; 
    ///@notice list of recorded lectures on IPFS    
    mapping(uint => bytes) recordedLecture;             
    ///@notice list of lectures owners       
    mapping(uint => mapping(address => bool)) accessLecture;

    event lecturePaid(address indexed teacher, address indexed student, uint256 lectureId);    

    /**
     * @dev generate lecture id
     * @return lecturesId lecture id
     */
    function generateLectureId() public returns (uint256) {
        lecturesId = lecturesId.add(1);
        return lecturesId;
    }

    /**
     * @dev pay for lecture
     * @param _lectureId id of lecture
     * @param _lecturePrice price of lecture
     * @param _teacher address of the lecture's teacher
     */
    function payLecture(uint _lectureId, uint _lecturePrice,address _student, address _teacher) public payable {
        require(msg.value == _lecturePrice, "insufficient amount of ether for lecture price");
        require(_teacher != address(0), "invalid teacher address");
        require(listedTeachers[_teacher] == 3, "teacher not found");

        //Mark lecture paid by student
        paidLecture[_lectureId][_student] = true;
        //Natanedu 3% fee per lecture
        uint natanFee = (msg.value * 3) / 100;
        //Transfer 97% to teacher balance
        teacherBalance[_teacher] += msg.value - natanFee;

        emit lecturePaid(_teacher, _student, _lectureId);
    }

    /**
     * @dev store IPFS hash of a recorded lecture
     * @param _lectureId id of lecture
     * @param _ipfsHash IPFS hash
     */
    function saveRecordedLecture(uint _lectureId, bytes memory _ipfsHash) internal {
        recordedLecture[_lectureId] = _ipfsHash;
        //restrict lecture access
        accessLecture[_lectureId][msg.sender] = true;
    }

    /**
     * @dev get IPFS hash of a recorded lecture
     * @param _lectureId id of lecture
     * @return IPFS hash
     */
    function getRecordedLecture(uint _lectureId) internal view returns(bytes memory) {
        require(accessLecture[_lectureId][msg.sender], "no permission to access this lecture");
        return recordedLecture[_lectureId];
    }

    /**
     * @dev tranfer money to specified teacher address
     * @param _teacher teacher address
     */
    function transfer(address payable _teacher) public {
        require(_teacher != address(0));
        require(listedTeachers[_teacher] == 3, "Teacher not authorized");
        require(teacherBalance[_teacher] > 0, "Teacher balance is zero");

        withdraw(_teacher);
    }

}
