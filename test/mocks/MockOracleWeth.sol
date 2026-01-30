// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;     

import {IStableOracle} from "../../contracts/interfaces/IStableOracle.sol";

contract MockOracleWeth is IStableOracle{
    function getPriceUSD() external pure override returns(uint256 ans){
        ans=291391000000*1e10;
    }
}