// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract HelloWorld {
    string public greet = "Hello World!";
}
contract Counter {
    uint256 public count;

    function get() public view returns (uint256) {
        return count;
    }
    function inc() public {
        count += 1;
    }
    function dec() public {
        count -= 1;
    }
}
contract Loop {
    function loop() public {
        for (uint256 i = 0; i < 10; i++) {
            if (i == 3) {
                continue;
            }
            if (i == 5) {
                break;
            }
        }
        uint256 j;
        while (j < 10) {
            j++;
        }
    }
}
contract Event {
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog();
    }
}


