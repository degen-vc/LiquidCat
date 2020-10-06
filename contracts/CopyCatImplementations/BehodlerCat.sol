// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "../CopyCat.sol";

contract BehodlerCat is CopyCat{
    function finalize () public override returns (bool){
        return true;
    }
    function claim() public override returns (bool){
       return true;
    }
}