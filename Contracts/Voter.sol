// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Voter{

    struct OptionPos {
        uint pos;
        bool exists;
    }

    uint[] public votes;
    string[] public options;
    mapping(address => bool) hasVoted;
    mapping(string => OptionPos) posOfOption;

    constructor(string[] memory _options){
        options= _options;
        votes = new uint[](_options.length);

        for(uint i=0; i<options.length; i++){
            OptionPos memory option = OptionPos(i, true);
            posOfOption[options[i]] = option;
        }
    }

    function vote(string memory option) public {
        require(!hasVoted[msg.sender],"Already voted");
        OptionPos memory optionPos = posOfOption[option];
        require(optionPos.exists, "Invalid option");

        recordVote(optionPos.pos);
    }
    // #1
    // function vote(uint option) public{
    //     require(option<options.length, "Invalid option");   
    //     require(!hasVoted[msg.sender],"Already voted");

    //     recordVote(option);     
    // }

    // #2
    // function vote(string memory option) public {
    //     require(!hasVoted[msg.sender],"Already voted");

    //     for(uint i=0; i<options.length;i++) {
    //         string memory currOption = options[i];
    //         if(stringEqual(option, currOption)){
    //             recordVote(i);
    //             return;
    //         }
    //     }

    //     revert();
    // }

    function stringEqual(string memory a, string memory b) private pure returns (bool) {
        return keccak256(bytes(a))==keccak256(bytes(b));
    }

    function recordVote(uint option) private {
        hasVoted[msg.sender]=true;
        votes[option] = votes[option]+1;
    }

    function getOptions() public view returns(string[] memory) {
        return options;
    }

    function getVotes() public view returns (uint[] memory) {
        return votes;
    }
 }