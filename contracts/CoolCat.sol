// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "./TopCat.sol";
import "./CopyCat.sol";
import "./facades/ERC20Like.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

/*
CoolCat is the staking/liquidity mining contract. It is responsible for taking an input token (couch)
and paying out a per-second reward token (catnip). CoolCat doesn't handle the final migration. For that,
refer the CopyCat contracts.
We use a normalized savings trick inspired by the Dai Savings Rate (pot.sol), except that instead of compounding, we 
grow linearly. This allows staking rewards without loopsa
*/

contract CoolCat{
    using SafeMath for uint;

    enum flowType {
        fixedDuration, //topping up with catnip increases reward rate
        fixedRewardRate //topping up with catnip increases duration of stake
        //perpetual?
    }

    enum stakingState {
        sleeping,
        scratching
    }

    struct contractAddresses{ //obligatory stack too deep error mention
        address topCat;
        address catnip;
        address couch;
        address copyCat;
    }
    
    struct stakingConfiguration {
        flowType flow;
        bool onlyHouseCats;
        uint flowValue; //time if duration and tokens per second if reward rate
    }

    struct catInfo {
        uint scratchMarks;
        uint landfillHeightAtLastJoin; 
        uint personalLitterBox; //the landfill is composed of all the litterboxes.
    }

    uint constant ONE = 1 szabo; // precision for fixed point arithmetic
    mapping (address=>bool) public houseCats; // KYC
    mapping (address => catInfo) public cats4pounds; //chaps in gowns
    stakingState public state;
    contractAddresses public addresses;
    stakingConfiguration public config;
    uint startingTime;
    uint public landfillHeight = ONE;
    uint initialCatnip = 0;
    uint baseCatnipPerSecond;

    modifier onlyCopyCat    {
        require(msg.sender == addresses.copyCat,'LIQUID CAT: only a copy cat can invoke this function.');
        _;
    }

    modifier scratchingInProgress {
        require (state == stakingState.scratching, "LIQUID CAT: staking not active");
        _;
    }

    constructor (address topCat, address catnip, address couch, address copyCat) public{
        addresses.topCat = topCat;
        addresses.catnip = catnip;
        addresses.couch = addresses.couch;
        addresses.copyCat = addresses.copyCat;
        state = stakingState.sleeping;
    }

    function configure (uint flow,bool onlyHouseCats, uint flowValue) public onlyCopyCat {
        config.flow = flowType(flow);
        config.onlyHouseCats = onlyHouseCats;
        config.flowValue = flowValue;
    }

    function lookWhatTheCatDraggedIn(uint value, address sender) private {
        require(ERC20Like(addresses.catnip).transferFrom(sender,address(this),value),"LIQUID CAT: transfer of catnip failed");
        if(config.flow == flowType.fixedDuration){
                uint timeLeft = now - startingTime;
                baseCatnipPerSecond = ERC20Like(addresses.catnip).balanceOf(address(this)).div(timeLeft);
        }else {
            baseCatnipPerSecond = config.flowValue;
        }
    }

    function lookWhatTheCatDraggedIn(uint value) private {
       lookWhatTheCatDraggedIn(value, msg.sender);
    }

    function wake (uint value) public onlyCopyCat {
        require (state == stakingState.sleeping,"LIQUID CAT: only sleeping cats can be woken");
        state = stakingState.scratching;
        startingTime = now;
    }
    
    function curiosity() public onlyCopyCat {

    }

    function finalize () public onlyCopyCat {
        //if staking, check if no longer staking,
        //set to finalized
    }

    function toggleOnlyHouseCats (bool e) public onlyCopyCat{
        config.onlyHouseCats = e;
    }

    function admitHouseCats( address[] memory cats, bool[] memory house ) public{
        for (uint i =0;i<cats.length;i++) {
            houseCats[cats[i]] = house[i];
        }
    }

    //process the consumed catnip
    function poop() public {

    }

    function scratch (uint value) public scratchingInProgress{

    }

    function retractClaws (uint value) public scratchingInProgress{

    }

    function timeUntilCatnipCrash() public view{
        
    }
}