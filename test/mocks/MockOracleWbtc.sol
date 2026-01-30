// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;     

import {IStableOracle} from "../../contracts/interfaces/IStableOracle.sol";

contract MockOracleWbtc is IStableOracle{
    function getPriceUSD() external pure override returns(uint256 ans){
        ans=8770784087430*1e10;
    }
}