pragma solidity ^0.4.4;


import "./utils/Control.sol";

/**
 * @title NatanAdmin
 * @dev The NatanAdmin contract has all the functions related to the admins of Natanedu platform
 */
contract NatanAdmin is Control {

    /**
     * @dev add new admin
     * @param newAllowed address of the new admin    
     */
    function addAdmin(address newAllowed) private onlyOwner {
        owners[newAllowed] = true;
    }

    /**
     * @dev remove admin
     * @param toRemove owner that will be removed
     */
    function removeAdmin(address toRemove) private onlyOwner {
        owners[toRemove] = false;
    }

}