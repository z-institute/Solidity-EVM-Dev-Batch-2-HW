// createInsurance.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract createInsurance {

    address public insured;
    address public investor;
    address payable public owner;

    uint256 public insuranceAmount;
    uint256 public insuranceFee;
    uint256 public rewards;
    uint public expirationDate;

    bool public isEstablished;

   constructor() {
        owner = payable(msg.sender);
    }

    function create() public {
        insured = msg.sender;

    }

    function cancelInsurance() public view {
	    require(msg.sender == insured, 'warning');
	    require(!isEstablished, 'warning');
	    //
    }

    function modifyInsuranceSetting() public view {
        require(msg.sender == insured, 'warning');
        require(!isEstablished, 'warning');

    }

    function fetchInsurance() public view {

    }

    function takeDeal() public payable returns (bool) {
	    require(msg.sender != insured, 'warning');
	    investor = msg.sender;
	    //Create an insurance pool
	    //Investor pledges insurance amount to the pool
	    //Should create NFT after deal success

	    //At the end
	    isEstablished = true;
	    return isEstablished;
    }

    function pledgeInsuranceAmount() internal {
    }

    function createInsuranceNFT() internal {
        //Insurance NFT
    }

    function cancelDealedInsurance() public view {
	    require(isEstablished, 'warning');
	    //Who can delete
    }

    function insuranceExpired() public {
	    //Can the contract keep getting the block number of blockchain?
    }

    function claimRewards() public payable {
	    require(msg.sender != investor, 'warning');
    }

    function withDrawInsuranceAmount() public view {
	    require(block.timestamp > expirationDate, 'warning');
	    require(msg.sender != investor, 'warning');
    }
}