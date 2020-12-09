// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.8.0;
pragma experimental ABIEncoderV2;

contract Patenter {
    struct Patent {
        uint uid;
        address owner;
        string applicantsName;
        string inventor;
        string agentName;
        string state;
        string registrationAddress;
        string title;
        string link;
        string country;
        uint patentNumber;
        uint decisionNumber;
        string decisionDate;
        uint lawNumber;
        uint internationalClassificationNumber;
        string responsiblePerson;
    }
    
    event CreatePatent(uint uid, address by);
    event UpdatePatent(uint uid, address by);
    
    mapping (uint => Patent) patents;
    uint[] public patentUids;

    function getPatents() public view returns (Patent[] memory) {
        Patent[] memory res = new Patent[](patentUids.length);
        for (uint i = 0; i < patentUids.length; i++) {
            uint uid = patentUids[i];
            res[i] = patents[uid];
        }
        return res;
    }
    function getPatent(uint uid) public view returns (Patent memory) {
        return patents[uid];
    }
    
    function createPatent(address _owner, string memory _inventor, string memory _applicantsName, string memory _agentName, string memory _state, string memory _registrationAddress, string memory _title, string memory _link, string memory _country) public returns (uint uid){
        uid = uint(keccak256(abi.encodePacked(msg.sender, block.number, block.timestamp)));
        patentUids.push(uid);
        patents[uid] = Patent(uid, _owner, _applicantsName, _inventor, _agentName, _state, _registrationAddress, _title, _link, _country, 0, 0, "", 0, 0, "");
        emit CreatePatent(uid, _owner);
    }
    
    function transferOwnership(uint uid, address to) public {
        Patent memory patent = patents[uid];
        require(msg.sender == patent.owner);
        patent.owner = to;
        patents[uid] = patent;
        emit UpdatePatent(uid, msg.sender);
    }
}