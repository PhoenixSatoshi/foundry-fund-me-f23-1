//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    //Create Library to use math functionality in desired contract

    function getPrice(
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        //address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI
        //AggregatorV3Interface priceFeed = AggregatorV3Interface(
        //   0x694AA1769357215DE4FAC081bf1f309aDC325306
        //  );
        (, int256 price, , , ) = priceFeed.latestRoundData();
        //will retrieve price of ETH in terms of USD(get info in chainlink github repository)
        //Price will come without decimals-Get decimals in github repository
        return uint256(price * 1e10);
    }

    function getConversionRate(
        uint256 ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
        //must divide to reduce number(multiply before you divide in solidity)
        //1 ETH -(2000_000000000000000000 * 1_000000000000000000) / 1e18; $2000=1ETH
    }

    function getVersion() internal view returns (uint256) {
        return
            AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
                .version();
    }
}
