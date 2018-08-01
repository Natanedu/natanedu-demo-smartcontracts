pragma solidity ^0.4.4;


contract Lecture {

    mapping(uint => bool) payedLecture;
    mapping(uint => bytes) recordedLecture;
    mapping(uint => mapping(address => bool)) accessLecture;
    
    constructor() {
        // constructor
    }

    function payLecture(uint _lectureId, uint _lecturePrice) external payable {
        require(msg.value == _lecturePrice);
        payedLecture[_lectureId] = true;
    }

    function saveRecordedLecture(uint _lectureId, bytes _ipfsHash) public {
        recordedLecture[_lectureId] = _ipfsHash;
        accessLecture[_lectureId][msg.sender] = true;
    }

    function getRecordedLecture(uint _lectureId) view public returns(bytes) {
        require(accessLecture[_lectureId][msg.sender]);
        return recordedLecture[_lectureId];
    }

}
