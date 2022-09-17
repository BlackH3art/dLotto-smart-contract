// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Lottery {

  uint8[] public rangeArray;
  uint8[] public winningArray;
  uint128 public ticketId;

  constructor() {
    rangeArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36];
    ticketId = 0;
  }


  // get number from rangeArray and push to winningArray
  // after the is pushed to winningArray, delete it from the rangeArray 
  // so all the numbers are uniqe
  // *** INTERNAL ***
  function getNumber(uint256 number) public {
    winningArray.push(rangeArray[number]);

    delete rangeArray[number];

    for(uint256 i = number; i < rangeArray.length - 1; i++) {
      rangeArray[i] = rangeArray[i + 1];
    }
  }

  // pass here array of random numbers from chainlink to receive 
  // winningArray of 6 random numbers
  // *** INTERNAL ***
  // *** WARNING ***
  // this may be gas consuming, check if Chainlink will be able
  // to execute this function in fallback
  function setWinningArray(uint256[] memory randomNumbers) public {

    getNumber(randomNumbers[0] % rangeArray.length);
    getNumber(randomNumbers[1] % rangeArray.length);
    getNumber(randomNumbers[2] % rangeArray.length);
    getNumber(randomNumbers[3] % rangeArray.length);
    getNumber(randomNumbers[4] % rangeArray.length);
    getNumber(randomNumbers[5] % rangeArray.length);
  }

















}