// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

interface IWhitelist {
    
    function addAddressToWhitelist(address _address) external;
    function isWhitelistedAddress(address _address) external returns(bool);
}

contract GardenNFT is ERC721{

    constructor (address _whitelistContract) ERC721("GardenNFT", "GRD") {
        whitelist = IWhitelist(_whitelistContract);
    }

    uint8 private constant MAX_DAY = 31;
    struct GardenData {
        uint256[MAX_DAY] flowers;
        uint256 month;
    }

    IWhitelist whitelist;

    mapping (uint => GardenData) private gardenDatas;
    uint256 gardenCount = 0;

    mapping (address => bool) monthMintedUsers;

    function mint(address _to, uint256[MAX_DAY] calldata _flowers) external onlyWhitelist(_to) {
        require(monthMintedUsers[_to] == false, "User has already been minted this month");

        uint256 newTokenId = makeTokenId();

        _safeMint(_to, newTokenId);
        GardenData storage newGarden = gardenDatas[newTokenId];
        // TODO : 테스트 코드이므로 변경해야 합니다.
        newGarden.month = 1;
        for (uint i = 0; i < _flowers.length; ++i) {
            newGarden.flowers[i] = _flowers[i];
        }

        ++gardenCount;
    }

    function getGardenData(uint256 _tokenId) external view returns(uint256[MAX_DAY] memory _flowers, uint256 _month) {
        require(ownerOf(_tokenId) != address(0), "NFT not found");

        GardenData storage gardenData = gardenDatas[_tokenId];
        _flowers = arrayCopy(_flowers, gardenData.flowers);
        _month = gardenData.month;
    }

    // 이후 tokenId 정책이 수립되면 변경합니다.
    function makeTokenId() internal view returns(uint256) {
        return gardenCount;
    }

    function arrayCopy(uint256[MAX_DAY] memory _lv, uint256[MAX_DAY] memory _rv) internal pure returns(uint256[MAX_DAY] memory) {
        for(uint16 i = 0; i < MAX_DAY; ++i) {
            _lv[i] = _rv[i];
        }

        return _lv;
    }

    modifier onlyWhitelist (address _address) {
        require(whitelist.isWhitelistedAddress(_address), "Address is not whitelist member");
        _;
    }

}