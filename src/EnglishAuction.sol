// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract EnglishAuction {
    constructor() {
        // init values
        // owner and NFT
    }

    function bid() external payable {
        // validations
        // highest bidder, all bids, highest bidder
    }

    function start() external onlyOwner {
        // validations
        // update the auction state
    }

    function end() external onlyOwner {
        // validations
        // highest bidder receive the item
        // owner receives ether
    }

    function withdraw() external {
        // bidder to receive fund from the all bids state
    }
}
