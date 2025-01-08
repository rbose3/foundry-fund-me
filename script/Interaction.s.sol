//SPDX-License-Identifier: MIT

//Fund
//Withdraw

pragma solidity ^0.8.18;
import {Script, console} from "../forge-std/Script.sol";
import {DevOpsTools} from "../foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";
contract FundFundMe is Script {
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    function fundFundMe(address mostRecentDeployed) public {
        vm.prank(USER);
        vm.deal(USER, 1e18);
        FundMe(payable(mostRecentDeployed)).fund{value: SEND_VALUE}();
        console.log("FundME successfully funded with %s", SEND_VALUE);
    }
    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundFundMe(mostRecentDeployed);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentDeployed)).withdraw();
        vm.stopBroadcast();
        console.log("FundME successfully withdraw %s", FundMe(payable(mostRecentDeployed)).getOwner().balance); 
    }
    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        withdrawFundMe(mostRecentDeployed);
        vm.stopBroadcast();
    }
}
