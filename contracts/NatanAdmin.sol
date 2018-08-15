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
    function addAdmin(address _newAllowed) external onlyOwner {
        require(_newAllowed != address(0), "invalid address");
        owners[_newAllowed] = true;
    }

    /**
     * @dev remove admin
     * @param toRemove owner that will be removed
     */
    function removeAdmin(address _toRemove) external onlyOwner {
        require(_toRemove != address(0), "invalid address");
        require(owners[_toRemove] == true, "admin not found");
        owners[_toRemove] = false;
    }

}