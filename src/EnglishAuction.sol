// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IERC721 {
    function transferFrom(address from, address to, uint256 tokenId) external;
}

contract EnglishAuction {
    // auction states
    bool public started;
    bool public ended;
    uint public endTime;
    // bid states
    uint public highestBid;
    address public highestBidder;
    mapping(address => uint) public allBids;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // for constructor
    address payable public immutable owner;
    IERC721 public immutable nft;
    uint public immutable nftId;

    constructor(address _nft, uint _nftId) {
        // init values
        owner = payable(msg.sender);
        // owner and NFT
        nft = IERC721(_nft);
        nftId = _nftId;
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
