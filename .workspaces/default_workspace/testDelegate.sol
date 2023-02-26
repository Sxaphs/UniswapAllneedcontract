// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// NOTE: Deploy this contract first
contract B {
    // NOTE: storage layout must be the same as contract A
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable {
        num = 2*_num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract testDelegateA{
    uint public num;
    address public sender;
    uint public value;
    
    function setVars(address _address, uint _num) external payable{
    bytes memory  data;
    (bool success, bytes memory _data)  = _address.delegatecall(
        abi.encodeWithSelector(B.setVars.selector, _num)
        );
    require(success, "no");
    data=_data;

    }
}