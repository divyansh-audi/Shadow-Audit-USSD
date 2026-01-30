// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;     

import {Test} from "../../lib/forge-std/src/Test.sol";
import {IERC20} from "../../lib/forge-std/src/interfaces/IERC20.sol";
import {console2} from "../../lib/forge-std/src/console2.sol";
import {USSD} from "../../contracts/USSD.sol";
import {MockOracleDAI} from "../mocks/MockOracleDAI.sol";
import {MockOracleWeth} from "../mocks/MockOracleWeth.sol";
import {MockOracleWbtc} from "../mocks/MockOracleWbtc.sol";
import {MockOracleWbgl} from "../mocks/MockOracleWbgl.sol";
import {MockWbgl} from "../mocks/MockWbgl.sol";
import {MockDai} from "../mocks/MockDai.sol";
import {MockWbtc} from "../mocks/MockWbtc.sol";
import {MockWeth} from "../mocks/MockWeth.sol";

contract USSDTest is Test{
    USSD public ussd;
    address public ADMIN=makeAddr("admin");

    uint256 wbtcStableOraclePrice=8770784087430*1e10;
    uint256 wethStableOraclePrice=291391000000*1e10;
    uint256 daiStableOraclePrice=wethStableOraclePrice*1e18/(341853119746047*1e10);
    uint256 wbglStableOraclePrice=42075941585*1e16;

    MockOracleDAI daiOracle;
    MockOracleWbgl wbglOracle;
    MockOracleWbtc wbtcOracle;
    MockOracleWeth wethOracle;
    MockWeth weth;
    MockWbtc wbtc;
    MockWbgl wbgl;
    MockDai dai;

    function setUp()public{
        ussd=new USSD();
        ussd.initialize("USSDToken","USSD");
        daiOracle=new MockOracleDAI();
        wbglOracle=new MockOracleWbgl();
        wbtcOracle =new MockOracleWbtc();
        wethOracle=new MockOracleWeth();
        weth=new MockWeth();
        wbtc=new MockWbtc();
        dai=new MockDai();
        wbgl=new MockWbgl(); 

        ussd.grantRole(ussd.STABLE_CONTROL_ROLE(), ADMIN);

        uint256[] memory arr = new uint256[](1);
        arr[0]=0;
        vm.startPrank(ADMIN);
        ussd.addCollateral(address(dai),address(daiOracle),true,true,arr,"","",0);
        ussd.addCollateral(address(weth),address(wethOracle),true,true,arr,"","",1);
        ussd.addCollateral(address(wbtc),address(wbtcOracle),true,true,arr,"","",2);
        ussd.addCollateral(address(wbgl),address(wbglOracle),true,true,arr,"","",3);
        vm.stopPrank();
    }

    function testgetCollateralIndexesReturnsIncorrectIndex(address _token) public {
        vm.startPrank(ADMIN);
        uint256 index=ussd.getCollateralIndex(_token);
        vm.stopPrank();
        if(_token!=address(weth) ||_token!=address(dai)||_token!=address(wbgl)||_token!=address(wbtc)){
            assertEq(index,ussd.collateralList().length);    
        }
    }

    function calculateCorrect(uint256 _amount,uint256 assetPrice,address _token) public returns(uint256){
        return (((assetPrice * _amount)) * (10 ** 6))/ ((10 ** IERC20(_token).decimals())*1e18);
    }

    function testcalculateMintWeth(uint256 _num)public {
        uint256 num=bound(_num,0,type(uint64).max);
        uint256 ap=wethOracle.getPriceUSD();
        uint256 correctCal=calculateCorrect(num,ap,address(weth));
        uint256 priceRecieving=ussd.calculateMint(address(weth),num);

        console2.log("correctCal",correctCal);
        console2.log("priceRecieving:",priceRecieving);
        assert(correctCal==priceRecieving);
    }

    function testcalculateMintWbtc(uint256 _num)public {
        uint256 num=bound(_num,0,type(uint64).max);
        uint256 ap=wbtcOracle.getPriceUSD();
        uint256 correctCal=calculateCorrect(num,ap,address(wbtc));
        uint256 priceRecieving=ussd.calculateMint(address(wbtc),num);

        console2.log("correctCal",correctCal);
        console2.log("priceRecieving:",priceRecieving);
        assert(correctCal==priceRecieving);
    }

    function testcalculateMintWbgl(uint256 _num)public {
        uint256 num=bound(_num,0,type(uint64).max);
        uint256 ap=wbglOracle.getPriceUSD();
        uint256 correctCal=calculateCorrect(num,ap,address(wbgl));
        uint256 priceRecieving=ussd.calculateMint(address(wbgl),num);

        console2.log("correctCal",correctCal);
        console2.log("priceRecieving:",priceRecieving);
        assert(correctCal==priceRecieving);
    }

    function testcalculateMintDai(uint256 _num)public {
        uint256 num=bound(_num,0,type(uint64).max);
        uint256 ap=daiOracle.getPriceUSD();
        uint256 correctCal=calculateCorrect(num,ap,address(dai));
        uint256 priceRecieving=ussd.calculateMint(address(dai),num);

        console2.log("correctCal",correctCal);
        console2.log("priceRecieving:",priceRecieving);
        assert(correctCal==priceRecieving);
    }
    
}