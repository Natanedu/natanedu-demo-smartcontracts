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
    
    mapping (address => uint) balance;

    function generateLectureId() public returns (uint256) {
        lecturesId = lecturesId.add(1);
        return lecturesId;
    }

    /**
     * @dev function to pay for lecture
     * @param _lectureId id of lecture
     * @param _lecturePrice price of lecture
     */
    function payLecture(uint _lectureId, uint _lecturePrice) external payable {
        require(msg.value == _lecturePrice, "insufficient amount of ether for lecture price");
        payedLecture[_lectureId][msg.sender] = true;
        balance[msg.sender] += msg.value;
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

}
