// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;     

import {ERC20} from "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MockWeth is ERC20{

    constructor()ERC20("WethToken","WETH"){

    }

    function decimals() public view override returns(uint8){
        return 18;
    }
}