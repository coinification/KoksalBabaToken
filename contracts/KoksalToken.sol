// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
//
// ..............................................................
//   @@@  @@@   @@@@@@   @@@  @@@   @@@@@@    @@@@@@   @@@       
//   @@@  @@@  @@@@@@@@  @@@  @@@  @@@@@@@   @@@@@@@@  @@@       
//   @@!  !@@  @@!  @@@  @@!  !@@  !@@       @@!  @@@  @@!       
//   !@!  @!!  !@!  @!@  !@!  @!!  !@!       !@!  @!@  !@!       
//   @!@@!@!   @!@  !@!  @!@@!@!   !!@@!!    @!@!@!@!  @!!       
//   !!@!!!    !@!  !!!  !!@!!!     !!@!!!   !!!@!!!!  !!!       
//   !!: :!!   !!:  !!!  !!: :!!        !:!  !!:  !!!  !!:       
//   :!:  !:!  :!:  !:!  :!:  !:!      !:!   :!:  !:!  :!:      
//   ::   :::  ::::: ::  ::   :::  :::: ::   ::   :::  :: :::::  
//    :   :::   : :  :    :   :::  :: : :     :   : :  : :: : : 
// ..............................................................
//
//  !! KÖKSAL BABA Token !!
//
//  KoksalBaba ($KOKS) is a meme coin, calling itself not a meme 
//  coin but “a fanbase movement.” It’s a cryptocurrency birthed 
//  by fans of Köksal Baba memes. The coin is named after the
//  master himself: Köksal Bektaşoğlu aka Koksal Baba.
//
//  🌔 Website:  https://koksal.rocks/
//  🌔 Telegram: https://t.me/+HbcdygOZnuk1Mjc0
//  🌔 Twitter:  https://twitter.com/KoksalToken
//  🌔 Discord:  https://discord.gg/......
//  🌔 Reddit:   https://www.reddit.com/r/KoksalToken
//  🌔 Github:   https://github.com/coinification/KoksalToken
//
// ..............................................................
//

// remix:
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

/// @custom:security-contact sec@koksal.rocks
contract KoksalBaba is ERC20, ERC20Burnable, ERC20Snapshot, Ownable, Pausable, ERC20Permit {
    
    // totalSupply
    uint256 private _totalSupply = 10000000000 * 10 ** decimals(); // 10B

    // wallet addresses
    address private _lpWallet = address(0xD198370eeEda409a41C9D73C2093dc263a45E0b1); // LP -> 80%
    address private _devWallet = address(0x2af31CDF54428acE9a811D2d5b4716042d3d09f4); // Dev -> 15%
    address private _koksWallet = address(0x742201Ca0c5A96301440D841dF22C13835b90Cec); // Koksal -> 5%
    
    // Events
    event tokensBurned(address indexed owner, uint256 amount, string message);
    event tokensMinted(address indexed owner, uint256 amount, string message);

    constructor() ERC20("KoksalBaba", "KOKS") ERC20Permit("KoksalBaba") {
        _mint(_lpWallet, (_totalSupply / 100 * 80));
        _mint(_devWallet, (_totalSupply / 100 * 10));
        _mint(_koksWallet, (_totalSupply / 100 * 5));

        emit tokensMinted(msg.sender, _totalSupply, "Initial supply of tokens minted!");
    }

    function snapshot() public onlyOwner {
        _snapshot();
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function burn(uint256 amount) public override onlyOwner {
        _burn(msg.sender, amount);
        emit tokensBurned(msg.sender, amount, "Tokens burned!");
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override(ERC20, ERC20Snapshot)
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}
