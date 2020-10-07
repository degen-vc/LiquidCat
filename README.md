# Liquid Cat
An Ethereum factory for liquidity mining and other such staking joys.

**Note: Until deployment, this document is subject to change**

## Topology
The dapp is comprised of 2 main contracts and a contract interface. 

### Topcat
This is the master factory contract and is responsible for deploying individual staking contracts. Topcat is owned and acts as a staking contract creating gatekeeper. A fee can be charged to users who wish to deploy staking contracts via Topcat. Users can be whitelisted to avoid incurring fees

### Coolcat
This is the core staking contract. Topcat deploys Coolcats Coolcat defines a reward token (catnip) and an input token (couch). When a user joins coolcat as a staker, they 'scratch'.
Coolcat has 2 modes: fixed reward rate and fixed duration. For the former, a certain quantity of catnip per second is streamed to all staked accounts who share the reward in proportion of their stake. Fixed duration divides the total catnip into the remaining seconds and streams this out evenly, also apportioned according to proportional stake.

### Copycat
Copycat is the entry point for governance of coolcat. Copycat is just an abstract contract. Depending on the concrete implemntations, Coolcat will either function as a simple staking contract or act as a liquidity mining contract with a migration step. At the end of the staking period, Copycat can present a finalization step to Coolcat. 
As an example, the Behodler Copycat will take all 'couch' tokens and inject them into Behodler in return for Scarcity. Staked addresses will then be able to withdraw Scarcity in proportion of their stake. 

By introducing governance through simple dependency injection, liquid cat is made future proof and flexible.

### FatCat

## NomenCATure
MakerDAO made a strong case for picking metaphors and using consistent language to prevent antipatterns and code smells arising. For instance, the Dai Savings Rate is implemented with a Pot contract that fills and pours. If a developer added a 'levitate' function to Pot, it would raise red flags. 
Similarly, Liquid Cat uses consisten cat based metaphors to keep the concepts internally consistent.

### TODO
1. Flesh out staking logic in CoolCat
2. Implement a concrete Copycat for Behodler liquidity mining.
3. Specify important boundary test cases and unit test