// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IERC721 {
    function transferFrom(address from, address to, uint256 tokenId) external;
}

contract EnglishAuction {
    // events
    event Start(uint stratTime, uint endTime);
    event Bid(address indexed bidder, uint value);
    event End(address indexed highestBidder, uint value);
    event Withdraw(address indexed bidder, uint value);

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
        require(started, "Auction not started");
        require(block.timestamp < endTime, "Auction ended");
        require(msg.value > highestBid, "Bid not high enough");

        // highest bidder, all bids, highest bidder
        allBids[highestBidder] += highestBid;
        highestBidder = msg.sender;
        highestBid = msg.value;

        emit Bid(msg.sender, msg.value);
    }

    function start(uint _openingBid, uint _duration) external onlyOwner {
        // validations
        require(!started, "Auction already started");

        // update the auction state
        highestBid = _openingBid;
        endTime = block.timestamp + _duration;
        nft.transferFrom(owner, address(this), nftId);
        started = true;

        emit Start(block.timestamp, endTime);
    }

    function end() external onlyOwner {
        // validations
        require(started, "Auction not started");
        require(!ended, "Auction already ended");
        require(block.timestamp >= endTime, "Auction not ended");

        ended = true;
        // highest bidder receive the item
        nft.transferFrom(address(this), highestBidder, nftId);
        // owner receives ether
        owner.transfer(highestBid);

        emit End(highestBidder, highestBid);
    }

    function withdraw() external {
        // bidder to receive fund from the all bids state
        uint amount = allBids[msg.sender];
        require(amount > 0, "No bid");
        allBids[msg.sender] = 0;
        payable(msg.sender).transfer(amount);

        emit Withdraw(msg.sender, amount);
    }
}
