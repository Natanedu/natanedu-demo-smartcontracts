pragma solidity ^0.4.4;

/**
 * @title Random
 */
contract Random {

    /**
     * @dev generate random number
     * @return number id
     */
    function generateRandomId() public view returns (uint) {
        uint lectureId = uint(keccak256(abi.encodePacked(block.difficulty, now)));
        return lectureId;
    }
}
