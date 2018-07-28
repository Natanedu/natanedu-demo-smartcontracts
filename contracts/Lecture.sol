pragma solidity ^0.4.4;


contract Lecture {

    mapping(uint => bool) payedLecture;
    
    constructor() {
        // constructor
    }

    function payLecture(uint _lectureId, uint _lecturePrice) public payable {
        require(msg.value == _lecturePrice);
        payedLecture[_lectureId] = true;
    }
}
