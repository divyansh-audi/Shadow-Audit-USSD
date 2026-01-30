// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;     

import {IStableOracle} from "../../contracts/interfaces/IStableOracle.sol";

contract MockOracleWbgl is IStableOracle{
    function getPriceUSD() external pure override returns(uint256 ans){
        ans=42075941585*1e16;
    }
}