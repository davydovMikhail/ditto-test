// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "./TestBaseUtil.t.sol";
import "src/interfaces/IERC7579Account.sol";
import "src/interfaces/IERC7579Module.sol";
import {ExecutionLogic} from "../src/DittoExecutionLogic/vault/logics/ExecutionLogic.sol";
import {IExecutionLogic} from "../src/DittoExecutionLogic/vault/interfaces/IExecutionLogic.sol";
import {IProtocolFees} from "../src/DittoExecutionLogic/IProtocolFees.sol";

contract DittoExecution is TestBaseUtil {
    address vault;

    function setUp() public override {
        super.setUp();
        IProtocolFees feeProtocol = IProtocolFees(address(0));
        vault = address(new ExecutionLogic(feeProtocol));
    }

    function test_ditto() public {
        vm.startPrank(vault);
        bytes memory setValueOnTarget = abi.encodeCall(MockTarget.setValue, 13545);

        IExecutionLogic(vault).execute(
            address(target),
            0,
            setValueOnTarget
            // abi.encodeWithSignature("balanceOf(address)", address(vault))
        );

        assertTrue(target.value() == 13545);
    }


}