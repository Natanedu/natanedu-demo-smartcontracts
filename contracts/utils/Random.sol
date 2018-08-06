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
        //return  uint256(keccak256(abi.encodePacked(block.difficulty, now)));
        return uint8(uint256(keccak256(block.timestamp, block.difficulty))%251);
    }
}
