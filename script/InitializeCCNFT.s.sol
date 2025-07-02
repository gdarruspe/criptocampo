//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {CCNFT} from "../src/CCNFT.sol";

contract InitializeCCNFT is Script {

    address constant CCNFT_CONTRACT_ADDRESS = 0x46A4F2132D6BFBdD616849Cb50f642f107692B17;
    address constant BUSD_CONTRACT_ADDRESS = 0xe4Ca44801a841B520379a777310efF4FE28110ea;
    address constant FUNDS_COLLECTOR_ADDRESS = 0x184176EB2269dec776F04038686fd9fd5EF12733;
    address constant FEES_COLLECTOR_ADDRESS = 0x480fEBa405B241AfFa49C4E63688741fB4cd9077;

    function run() external {
        vm.startBroadcast();

        CCNFT ccnft = CCNFT(CCNFT_CONTRACT_ADDRESS);

        ccnft.setFundsToken(BUSD_CONTRACT_ADDRESS);
        ccnft.setFundsCollector(FUNDS_COLLECTOR_ADDRESS);
        ccnft.setFeesCollector(FEES_COLLECTOR_ADDRESS);

        ccnft.setProfitToPay(100);
        ccnft.setCanBuy(true);
        ccnft.setCanClaim(true);
        ccnft.setCanTrade(true);
        ccnft.setMaxValueToRaise(10000000);
        ccnft.addValidValues(20);
        ccnft.setMaxBatchCount(3);
        ccnft.setBuyFee(1);
        ccnft.setTradeFee(2);
    }
}