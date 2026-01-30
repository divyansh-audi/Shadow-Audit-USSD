// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;     

import {IStableOracle} from "../../contracts/interfaces/IStableOracle.sol";

contract MockOracleDAI is IStableOracle{
    function getPriceUSD() external pure override returns(uint256 ans){
        ans=uint256(291391000000*1e10*1e18)/(341853119746047*1e10);
    }
}