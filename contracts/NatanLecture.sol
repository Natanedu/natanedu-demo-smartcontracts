pragma solidity ^0.4.4;


contract NatanLecture {

    mapping(uint => mapping(address => bool)) payedLecture;
    mapping(uint => bytes) recordedLecture;
    mapping(uint => mapping(address => bool)) accessLecture;
    

    function payLecture(uint _lectureId, uint _lecturePrice) external payable {
        require(msg.value == _lecturePrice, "insufficient amount of ether for lecture price");
        payedLecture[_lectureId][msg.sender] = true;
    }

    function saveRecordedLecture(uint _lectureId, bytes _ipfsHash) public {
        recordedLecture[_lectureId] = _ipfsHash;
        //restrict lecture access
        accessLecture[_lectureId][msg.sender] = true;
    }

    function getRecordedLecture(uint _lectureId) public view returns(bytes) {
        require(accessLecture[_lectureId][msg.sender], "no permission to access this lecture");
        return recordedLecture[_lectureId];
    }

}
