// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {CCNFT} from "../src/CCNFT.sol";

contract DeployCCNFT is Script {
    function run() external returns (CCNFT) {
        vm.startBroadcast();
        CCNFT ccNFT = new CCNFT();
        vm.stopBroadcast();

        return ccNFT; // Retorna la instancia para obtener su dirección.
    }
}
