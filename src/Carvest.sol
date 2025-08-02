// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Carvest {
  struct Contributor {
    uint amount;
    bool refunded;
  }

  struct Campaign {
    string name;
    string description;
    uint goal;
    uint deadLine;
    uint raisedAmount;
    uint startTime;
    bool isSuccessful;
    bool isLocked;
    bool isWithdrawn;
    address owner;
    mapping(address => Contributor) contributors;
  }

  mapping(uint => Campaign) public campaigns;
  uint public campaignIdCounter = 0;

  function createCampaign(string memory name, string memory description, uint goal, uint deadLine) public {
    require(bytes(name).length > 0, "Campaign name cannot be empty");
    require(bytes(description).length > 0, "Campaign description cannot be empty");
    require(goal > 0, "Campaign goal must be greater than zero");
    require(deadLine > block.timestamp, "Campaign deadline must be in the future");

    Campaign storage newCampaign = campaigns[campaignIdCounter++];
    newCampaign.owner = msg.sender;
    newCampaign.name = name;
    newCampaign.description = description;
    newCampaign.goal = goal;
    newCampaign.deadLine = deadLine;
    newCampaign.startTime = block.timestamp;
    newCampaign.isSuccessful = false;
    newCampaign.isLocked = false;
  }

  function contribute(uint campaignId) public payable {
    Campaign storage campaign = campaigns[campaignId];
    require(campaign.startTime > 0, "Campaign haven't been started");
    require(block.timestamp < campaign.deadLine, "Campaign has ended");
    require(!campaign.isLocked, "Campaign is locked");
    require(campaign.raisedAmount < campaign.goal, "Campaign goal has been reached");
    require(msg.value > 0, "Contribution must be greater than zero");

    Contributor storage contributor = campaign.contributors[msg.sender];
    contributor.amount += msg.value;
    campaign.raisedAmount += msg.value;
  }

  function getCampaign(uint campaignId) public view returns (string memory, string memory, uint, uint, uint, bool, bool, address) {
    Campaign storage campaign = campaigns[campaignId];
    return (
      campaign.name,
      campaign.description,
      campaign.goal,
      campaign.deadLine,
      campaign.raisedAmount,
      campaign.isSuccessful,
      campaign.isLocked,
      campaign.owner
    );
  }

 function lockCampaign(uint campaignId) public {
    Campaign storage campaign = campaigns[campaignId];
    require(msg.sender == campaign.owner, "Only the owner can lock the campaign");
    require(!campaign.isLocked, "Campaign is already locked");
    require(block.timestamp >= campaign.deadLine, "Cannot lock before deadline");

    if (campaign.raisedAmount >= campaign.goal) {
      campaign.isSuccessful = true;
    } else {
      campaign.isSuccessful = false;
    }
    campaign.isLocked = true;
  }

  function refund(uint campaignId) public {
    Campaign storage campaign = campaigns[campaignId];
    Contributor storage contributor = campaign.contributors[msg.sender];

    require(campaign.isLocked, "Campaign is not locked yet");
    require(!contributor.refunded, "Contributor has already been refunded");
    require(!campaign.isSuccessful, "Campaign was successful, no refunds allowed");

    uint amountToRefund = contributor.amount;
    require(amountToRefund > 0, "No contribution to refund");

    contributor.refunded = true;
    payable(msg.sender).transfer(amountToRefund);
  }

  function withdraw(uint campaignId) public {
    Campaign storage campaign = campaigns[campaignId];
    require(msg.sender == campaign.owner, "Only the owner can withdraw funds");
    require(campaign.isLocked, "Campaign is not locked yet");
    require(campaign.isSuccessful, "Campaign was not successful");

    require(!campaign.isWithdrawn, "Funds have already been withdrawn");
    campaign.isWithdrawn = true;

    payable(campaign.owner).transfer(campaign.raisedAmount);
  }

  function getContributorAmount(uint campaignId, address contributorAddress) public view returns (uint) {
    Campaign storage campaign = campaigns[campaignId];
    return campaign.contributors[contributorAddress].amount;
  }

  function isContributorRefunded(uint campaignId, address contributorAddress) public view returns (bool) {
    Campaign storage campaign = campaigns[campaignId];
    return campaign.contributors[contributorAddress].refunded;
  }
}
