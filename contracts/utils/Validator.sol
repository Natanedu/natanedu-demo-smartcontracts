pragma solidity 0.4.24;


/** @title Validator */
contract Validator {

    ///@notice list of used nonces
    mapping(uint256 => bool) usedNonces;

    /**
     * @dev generate a prefixed hash to mimic the behavior of eth_sign
     * @param hash hashed message
     */
    function prefixed(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }

    /**
     * @dev Check if an address signed a message
     * @param _lectureId lecture id
     * @param nonce random number to protect against replay attacks
     * @param sig the signed hash
     */
    function isSigned(uint _lectureId, uint256 nonce, bytes memory sig) public {
        require(!usedNonces[nonce], "replayed message");
        usedNonces[nonce] = true;

        // This recreates the message that was signed on the client.
        bytes32 message = prefixed(keccak256(abi.encodePacked(msg.sender, _lectureId, nonce, this)));

        require(recoverSigner(message, sig) == msg.sender, "this is not the message's signer");
    }

    /**
     * @dev function to get the address of the signer who signed the message
     * @param message the signed message
     * @param sig the signature
     * @return signer address
     */
    function recoverSigner(bytes32 message, bytes memory sig) internal pure returns (address) {
        
        uint8 v;
        bytes32 r;
        bytes32 s;

        (v, r, s) = splitSignature(sig);

        return ecrecover(message, v, r, s);
    }

    /**
     * @dev Function to split the signature
     * @param sig the signature
     * @return bytes
     */
    function splitSignature(bytes memory sig) internal pure returns (uint8, bytes32, bytes32) {
        require(sig.length == 65, "invalid signature length");
        
        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            // first 32 bytes, after the length prefix
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }

        return (v, r, s);
    }


}
