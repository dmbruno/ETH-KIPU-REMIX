// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";



contract ETHDevPackNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;
    
    

    constructor(address owner1)
        ERC721("ETH Dev Pack NFT", "EDP")
        Ownable(owner1)
    {}

    function safeMint(address to, string memory tokenURI) external onlyOwner {
        _tokenIds++;
        _safeMint(to, _tokenIds);
        _setTokenURI(_tokenIds, tokenURI);
    }
}