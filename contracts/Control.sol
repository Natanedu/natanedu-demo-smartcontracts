pragma solidity ^0.4.4;


/**
 * @title Control
 * @dev The controle contract has multiple owners addresses, and provides basic authorization 
 * control functions, this simplifies the implementation of "user permissions".
 */
contract Control {

    mapping(address => bool) internal owners;

    event OwnershipRenounced(address indexed previousOwner);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev The Control constructor sets the original `owner` of the contract to the sender
     * account.
     */
    constructor() public {
        owners[msg.sender] = true;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owners[msg.sender] == true);
        _;
    }

    /**
     * @dev add new owner
     * @param newAllowed address of the new owner    
     */
    function addOwner(address newAllowed) onlyOwner external {
        owners[newAllowed] = true;
    }

    /**
     * @dev remove owner
     * @param toRemove owner that will be removed
     */
    function removeOwner(address toRemove) onlyOwner external {
        owners[toRemove] = false;
    }

    /**
     * @dev Allows the current owner to relinquish control of the contract.
     */
    function renounceOwnership() external onlyOwner {
        emit OwnershipRenounced(msg.sender);
        owners[msg.sender] = false;
    }

}