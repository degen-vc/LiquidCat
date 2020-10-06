// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/*
CopyCat governs the state of CoolCat (staking contract). CopyCat is an entry point for
something as large as a DAO or as simple as a migration contract. CoolCats can have at most 1
CopyCat but a CopyCat instance can be associated with many CoolCats.
By following this pattern, we essentially allow governance via dependency injection, 
allowing decentralization be 'lazy loaded'. Yes, I like .Net 
*/
abstract contract CopyCat{
    function finalize () public virtual returns (bool);
    function wake () public virtual returns (bool);
    function killNineTimes () public virtual returns (bool);
}