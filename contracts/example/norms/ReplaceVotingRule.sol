pragma solidity ^0.4.11;

import "../../Valid.sol";
import "../../VotingInterface.sol";
import "../../LegislatorInterface.sol";
import "../../GDAO.sol";

/// @notice "substitute the court by a simple majority vote of party members";
contract ReplaceVotingRule is Valid{

    VotingInterface public newVoting;
    LegislatorInterface legislator;

    function ReplaceVotingRule(LegislatorInterface _legislator, VotingInterface _newvoting, GDAO _proxy) Valid(_proxy){

        newVoting = _newvoting;
        legislator = _legislator;
    }

    function execute() isValid external {
        legislator.setVoting(newVoting);
        NormCorpusInterface normCorpus = normCorpusProxy.getInstance();
        normCorpus.remove(this);
        selfdestruct(legislator);
    }
}
