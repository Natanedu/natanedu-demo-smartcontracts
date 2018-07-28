pragma solidity ^0.4.4;


contract Lecture {

    mapping(uint => bool) payedLecture;
    mapping(uint => string) recordedLecture;
    
    constructor() {
        // constructor
    }

    function payLecture(uint _lectureId, uint _lecturePrice) public payable {
        require(msg.value == _lecturePrice);
        payedLecture[_lectureId] = true;
    }

    function saveRecordedLecture(uint _lectureId, string _ipfsHash) public {
        recordedLecture[_lectureId] = _ipfsHash;
    }

}
