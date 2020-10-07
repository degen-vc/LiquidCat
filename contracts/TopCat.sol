// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "./facades/ERC20Like.sol";
/*
TopCat is a master factory contract for creating staking contracts (coolCat) and 
associating them with treasury contracts (fatCat). The relationship is 1:1.
TopCat can be deployed to derive a fee from deployment as a service.
The fee is a flap (as in door flat) because it is a barrier to entry
Whitelisted users who can deploy for no fee are feral because they are unhindered by flaps.
CatNip is the reward token for scratching (staking) and couch is the item you have to scratch
*/

contract TopCat is Ownable{ //rename liquid cat
    mapping (address=>address) public fatToCool;
    mapping (address=>address) public coolToFat;
    mapping (address=>bool) public feralCats; //no fee users
    mapping (address=>address) public tomCats; //users who deployed coolcats. Used for selfdestruct

    struct catFlap{
        uint width;
        address token;
    }
    catFlap public flap;

    function installFlap(address token, uint width) public onlyOwner {
        flap.token = token;
        flap.width = width;
    }

    function birthKitty(address copyCat, address catnip, address couch, uint flowType) public {
        if(flap.token !=address(0) && flap.width>0 && !feralCats[msg.sender]){
           require(ERC20Like(flap.token).transferFrom(msg.sender,address(this),flap.width),"LIQUID CAT: user must pay fee to launch a staking contract.");
        }
        //TODO: use create2 for predictalbe deployment address
        //TODO: transfer ownership to msg.sender (delegateCall?)
        //TODO: emit event
    }

    function withdraw () public onlyOwner {
        if(flap.token!=address(0) && flap.width>0){
            uint balance = ERC20Like(flap.token).balanceOf(address(this));
            if(balance>0) ERC20Like(flap.token).transfer(msg.sender,balance);
        }
    }
}