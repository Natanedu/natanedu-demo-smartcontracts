pragma solidity ^0.4.4;


contract Lecture {

    mapping(uint => bool) payedLecture;
    mapping(uint => bytes) recordedLecture;
    
    constructor() {
        // constructor
    }

    function payLecture(uint _lectureId, uint _lecturePrice) external payable {
        require(msg.value == _lecturePrice);
        payedLecture[_lectureId] = true;
    }

    function saveRecordedLecture(uint _lectureId, bytes _ipfsHash) public {
        recordedLecture[_lectureId] = _ipfsHash;
    }

    function getRecordedLecture(uint _lectureId) view public returns(bytes) {
        return recordedLecture[_lectureId];
    }

}
