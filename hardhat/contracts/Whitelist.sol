// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Whitelist is Ownable {
    
    constructor() Ownable(msg.sender){}

    mapping (address => bool) whitelistedAddresses;
    uint256 numAddressWhitelisted;

    function addAddressToWhitelist(address _address) external {
        require(!whitelistedAddresses[_address], "Address has already been whiltelisted");

        whitelistedAddresses[_address] = true;
    }

    function isWhitelistedAddress(address _address) external view returns(bool) {
        return whitelistedAddresses[_address];        
    }
}
