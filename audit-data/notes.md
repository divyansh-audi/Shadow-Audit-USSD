contracts
    interfaces
        IStableOracle.sol
        IStaticOracle.sol
        IUSSDRebalancer.sol
    oracles
        StableOracleDAI.sol
        StableOracleWBGL.sol
        StableOracleWBTC.sol
        StableOracleWETH.sol
    USSDRebalancer.sol
    USSD.sol

### getOwnValuation() can be frontrun
- There exists this DAI/USSD Pool
- so for instance the pool has 10_000e18 DAI and 10_000e6 USSD initially
- 