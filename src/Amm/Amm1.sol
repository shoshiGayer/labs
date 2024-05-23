// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix

pragma solidity ^0.8.20;

import "../like/IERC20.sol";
import "forge-std/console.sol";
import "../audit/approve.sol";

contract Amm1 {
    ERC20 x;
    ERC20 y;
    uint256 k;
    uint256 WAD;
    mapping(address => uint256) public balances;

    constructor() {
        x.approve(address(this), 1000);
        x.mint(1000);
        y.approve(address(this), 1000);
        y.mint(1000);
        k = x.balanceOf(address(this)) * y.balanceOf(address(this));
        WAD = 10 ** 18;
    }

    function price() public view returns (uint256) {
        return x.balanceOf(address(this)) > y.balanceOf(address(this))
            ? (x.balanceOf(address(this)) * WAD / y.balanceOf(address(this)))
            : (y.balanceOf(address(this)) * WAD / x.balanceOf(address(this)));
    }

    function tradeXToY(uint256 amount) public returns (uint256) {
        require(amount > 0, "amount is illegal");
        x.transferFrom(address(msg.sender), address(this), amount);
        uint256 amountY = y.balanceOf(address(this)) * WAD / price();
        uint256 result = y.balanceOf(address(this)) - amountY;
        require(result < y.balanceOf(address(this)), "There is no enough liquidity");
        y.transfer(address(msg.sender), result);
        return result;
    }

    function tradeYToX(uint256 amount) public returns (uint256) {
        require(amount > 0, "amount is illegal");
        y.transferFrom(address(msg.sender), address(this), amount);
        uint256 amountX = x.balanceOf(address(this)) * WAD / price();
        uint256 result = x.balanceOf(address(this)) - amountX;
        require(result < x.balanceOf(address(this)), "There is no enough liquidity");
        x.transfer(address(msg.sender), result);
        return result;
    }

    function addLiquidity(uint256 amountX, uint256 amountY) public {
        //->amount
        uint256 rate = amountX > amountY ? (amountX * WAD / amountY) : (amountY * WAD / amountX);
        require(rate == price(), "rate not equal");
        x.transferFrom(address(msg.sender), address(this), amountX);
        y.transferFrom(address(msg.sender), address(this), amountY);
        k = x.balanceOf(address(this)) * y.balanceOf(address(this));
        balances[msg.sender] += amountX;
    }

    function removeLiquidity(uint256 amountX, uint256 amountY) public {
        //->amount
        uint256 rate = amountX > amountY ? (amountX * WAD / amountY) : (amountY * WAD / amountX);
        require(rate == price(), "rate not equal");
        require(amountX <= x.balanceOf(address(this)));
        require(amountY <= y.balanceOf(address(this)));
        require(amountX <= balances[msg.sender]);
        x.burn(amountX);
        y.burn(amountY);
        k = x.balanceOf(address(this)) * y.balanceOf(address(this));
        balances[msg.sender] -= amountX;
    }
}
