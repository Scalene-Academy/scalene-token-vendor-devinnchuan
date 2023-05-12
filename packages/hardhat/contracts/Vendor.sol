pragma solidity 0.8.19; //Do not change the solidity version as it negativly impacts submission grading
// SPDX-License-Identifier: MIT

// learn more: https://docs.openzeppelin.com/contracts/4.x/api/access#Ownable
// @TODO: Vendor should inherit Ownable
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./YourToken.sol";

// @TODO: Implement the Vendor smart contract
contract Vendor is Ownable{
    uint256 public constant tokensPerEth = 100;

    YourToken public yourToken; // Instance of YourToken contract

    constructor(address tokenAddress) {
        yourToken = YourToken(tokenAddress); // Initialize the YourToken instance
    }

    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

    function buyTokens() public payable{
        uint256 amount = msg.value * tokensPerEth;
        yourToken.transfer(msg.sender, amount);
        emit BuyTokens(msg.sender, msg.value, amount);
    }

    //Withdraw all ETH from contract to owner address
    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function sellTokens(uint256 amount) public {

    uint256 ethAmount = amount / tokensPerEth;

    // Transfer tokens from the user to the contract
    yourToken.transferFrom(msg.sender, address(this), amount);

    // Transfer ETH from the contract to the user
    payable(msg.sender).transfer(ethAmount);
    }

}
