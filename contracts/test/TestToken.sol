// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TestToken is ERC20 {
    constructor() ERC20("ZKProver Token", "ZPB") {
        _mint(msg.sender, 10000000000 ether);
    }

    function mint(address to, uint256 amount) external {
        require(amount <= 100 ether, "Amount overflow");

        _mint(to, amount);
    }
}
