// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {EnglishAuction} from "../src/EnglishAuction.sol";

contract EnglishAuctionScript is Script {
    EnglishAuction public englishauction;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // englishauction = new EnglishAuction();

        vm.stopBroadcast();
    }
}
