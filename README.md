# Liquid Cat
An Ethereum factory for liquidity mining and other such staking joys.

**Note: Until deployment, this document is subject to change**

## NomenCATure
MakerDAO made a strong case for picking metaphors and using consistent language to prevent antipatterns and code smells arising. For instance, the Dai Savings Rate is implemented with a Pot contract that fills and pours. If a developer added a 'levitate' function to Pot, it would raise red flags. 
Similarly, Liquid Cat uses consisten cat based metaphors to keep the concepts internally consistent. It may not be *purrfect but we like it.

## Topology
The dapp is comprised of 2 main contracts and a contract interface. 

### Topcat
This is the master factory contract and is responsible for deploying individual staking contracts. Liquidcat is owned and acts as a staking contract creating gatekeeper. A fee could be charged to users who wish to deploy staking contracts via Topcat. If we go this route we would label their deployed contracts Copycats. Users can be whitelisted to avoid incurring fees

### Alphacat
This the DGVC LP perpetual staking rewards contract. It is essentially the first Coolcat (see below). Going forward, Alphadrops will simply drop into Alphacat to reward LP stakers. Alphadrops might also adher to <fpieper> snapshots recorded on a layer 2 as articulated in the VIP_1 in discord. Also, rewards such as "fees" mentioned above and any and every future reward that we can conceive can be poured into Alphacat at any point in time. Rewards that acrue for every second staked will be farmed when users withdraw liquidity.

### Coolcats
Liquidcat spawns Coolcats. Alphacat will actually be one of the first Coolcats. Coolcats have a plethora of functions and emphases depending on the parameters used. The architecture is being created to accommodate all and every future innovation and it will afford developers the opportunity to innovate on our ecosystem (the first principal opportunity for which is our upcoming Gitcoin Hackathon). Initially, these functions include staking for the purpose of farming, liquidity mining (Behodler.io), liquidity raising (our innovations around tokensales formerly discussed as the Liquidity Mining Protocol) and NFT mining.  For example, for a staking Coolcat (Alphacat for instance) the smart contract defines a reward token (catnip) and an input token (couch). When a user joins a staking Coolcat as a staker, they 'scratch'. Staking Coolcats have 2 modes: fixed reward rate and fixed duration. For the former, a certain quantity of catnip per second is streamed to all staked accounts who share the reward in proportion of their stake. These rewards are farmed when a user withdraws liquidity or when the staking period concludes. Fixed duration divides the total catnip into the remaining seconds and streams this out evenly, also apportioned according to proportional stake.

### Catwalk
Catwalk is the entry point for governance of Coolcats along with any other future addition that could be desireable. Catwalk is just an abstract contract, thus the meandering name. Depending on the concrete implementations. As mentioned above, Coolcats can function in many ways for instance as a simple staking contract or as a liquidity mining contract with a migration step. For the latter, at the end of the mining period, Catwalk can present a finalization step to Coolcat. For example, The Behodler Copycat will take all 'couch' tokens and inject them into Behodler in return for Scarcity. Staked addresses will then be able to withdraw Scarcity in proportion of their stake. 

By introducing governance through simple dependency injection, Liquid Cat is made future proof and flexible.

### Fatcat
Fatcat is a treasury contract that removes the need for projects to employ ideosyncratic token locking mechanisms. For example, a Fatcat could govern token allocations to three different Coolcats during a project's lifecycle: alphadrop, staking farming and liquidity fundraising.

### TODO
1. Flesh out logic in various forms of CoolCat
2. Implement a concrete Catwalk for Behodler liquidity mining.
3. Specify important boundary test cases and unit tests to prepare for Gitcoin Hackathon bounties around audit.
