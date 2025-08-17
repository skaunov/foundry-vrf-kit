// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// based on <https://docs.dcipher.network/quickstart/randomness/#3-create-a-randomness-consumer-contract>

// <https://docs.dcipher.network/>
import { RandomnessReceiverBase } from "lib/randomness-solidity/src/RandomnessReceiverBase.sol";

/// The logic will be divided by `requestRandomness()` into halfs; the first one prepares everything you want before getting the randomness (mind that everything that could be exploited 
/// by knowing the randomness should be saved/committed/locked at this point) --- it's represented by the saved structure and concludes emitting 
/// `requestId`. The second half will happen in a future block triggered by the callback (`onRandomnessReceived`) and finishing the logic.
contract RandomConsumer is RandomnessReceiverBase {
    mapping(uint256 => StateAwaitingCallback) internal pendingRequests;

    event RandomnessRequested(uint256 indexed requestId);
    event RandomnessFulfilled(uint256 indexed requestId, bytes32 randomValue);

    /// @notice If any data is needed to resume with after the call-back you will need to save that, if not: `mapping(uint256 => bool) pendingRequests` would be enough. 
    /// For the sake of example here is something between these two.
    struct StateAwaitingCallback {
        bool exists;
    }
 
    constructor(address randomnessSender) RandomnessReceiverBase(randomnessSender) {}

    /// @notice It's a great idea to optimize this out along to the concrete set up!
    function requestRandomness(bool withSubscription, uint32 callbackGasLimit) internal returns (
        uint256 requestId, uint256 requestPrice
    ) {
        if (withSubscription) {
            return (_requestRandomnessWithSubscription(callbackGasLimit), 0);
        } else {
            return _requestRandomnessPayInNative(callbackGasLimit);
        }
    }
    
    /// @notice the first half of the logic goes here
    function getRandomness(bool withSubscription, uint32 callbackGasLimit) external {
        (uint256 requestId, uint256 _requestPrice) = requestRandomness(withSubscription, callbackGasLimit);
        
        // your logic goes here
        
        pendingRequests[requestId] = StateAwaitingCallback(true);
        emit RandomnessRequested(requestId);
    }

    /// @notice called back by the `randomnessSender` to fulfill the request    
    function onRandomnessReceived(uint256 requestID, bytes32 _randomness) internal override {
        StateAwaitingCallback fulfiedRequest = pendingRequests[requestID];
        delete pendingRequests[requestID];
        require(fulfiedRequest.exists == true, "Only a requested Id can be called back!");
        
        // Use `_randomness` in the final part of your logic/actions.
        
        emit RandomnessFulfilled(requestID, _randomness);
    }
}