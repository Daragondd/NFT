//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract GensinHeroes is ERC721, Ownable, IERC721Receiver {
    using Counters for Counters.Counter;
    
    Counters.Counter private tokenIDs;
    mapping(uint256 => string) private _tokenURIs;

    modifier onlyTokenOwner(uint256 _tokenId) {
        require(ownerOf(_tokenId) == _msgSender(), "It's not your token");
        _;
    }

    constructor() ERC721 ("Genshin Impact Heroes", "GENSHIN_HEROES") {}

    function tokenURI(uint256 _tokenID) public view override returns (string memory){
        require(_exists(_tokenID), "Invalid tokenId");
        string memory _tokenURI = _tokenURIs[_tokenID];

        return _tokenURI;
    }

     function mint(
        address _owner, 
        string memory _tokenURI
    ) public onlyOwner {
        _safeMint(_owner, tokenIDs.current());
        _setTokenURI(tokenIDs.current(), _tokenURI);

        tokenIDs.increment();
    }

    function _setTokenURI(
        uint256 tokenID, 
        string memory _tokenURI
    ) internal {
        require(_exists(tokenID), "URI set of nonexistent token");
        _tokenURIs[tokenID] = _tokenURI;
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenID,
        bytes calldata data
    ) public override returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }
}