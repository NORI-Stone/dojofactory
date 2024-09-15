// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {MCDevKit} from "@mc/devkit/Flattened.sol";
import { Dojo } from "../src/main/functions/Dojo.sol";



library DeployLib {
    function bundleName() internal returns(string memory) {
        return "Dojo";
    }

    function deployCounter(MCDevKit storage mc, uint256 initialNumber) internal returns(MCDevKit storage) {
        mc.init(bundleName());
        address _dojoAddr = address(new Dojo());
        mc.use("initialize", Dojo.initialize.selector, _dojoAddr);
        mc.use("getLevel", Dojo.getLevel.selector, _dojoAddr);
        mc.use("getRankedRole", Dojo.getRankedRole.selector, _dojoAddr);
        mc.use("applyForMembership", Dojo.applyForMembership.selector, _dojoAddr);
        mc.use("getLevelsFromAllFactions", Dojo.getLevelsFromAllFactions.selector, _dojoAddr);
        mc.use("promote", Dojo.promote.selector, _dojoAddr);
        mc.use("assignRole", Dojo.assignRole.selector, _dojoAddr);
        // mc.useFacade(address(new CounterFacade()));
        // mc.deploy(abi.encodeCall(Dojo.initialize, initialNumber));
        return mc;
    }
}
