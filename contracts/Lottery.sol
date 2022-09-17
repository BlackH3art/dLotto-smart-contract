// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Lottery {

  address owner; 
  uint8[] public rangeArray;
  uint8[] public winningArray;
  uint128 public ticketId;

  uint8[6][] public ticketsArray;
  address[] public ticketOwnersArray;

  address[] public sixWinners;
  address[] public fiveWinners;
  address[] public fourWinners;
  address[] public threeWinners;

  uint256 public ticketPrice;
  uint256 public prizePool;
  uint256 public protocolFee;


  constructor() {
    owner = msg.sender;

    rangeArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36];
    ticketId = 0;

    // later set it to 1 ether
    ticketPrice = 10000000000000000; // 0.01 ether
  }



  // ===================================================
  //                  INTERNAL INTERFACE
  // ===================================================


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



  // ===================================================
  //                  PUBLIC INTERFACE
  // ===================================================

  // *** PAY TICKET PRICE ***
  function buyTicket(
    uint8 first,
    uint8 second,
    uint8 third,
    uint8 fourth,
    uint8 fifth,
    uint8 sixth
  ) public payable {

    // 80% from the ticket price go to prizePool
    prizePool = (msg.value / 100) * 80;
    // 20% from the ticket price go to protocolFee and is claimable by admin.
    protocolFee = (msg.value / 100) * 20;

    ticketsArray.push([first, second, third, fourth, fifth, sixth]);
    ticketOwnersArray.push(msg.sender);

    ticketId++; 
  }



  // ===================================================
  //                  ADMIN INTERFACE
  // ===================================================


  // admin check for winners and push them to arrays eligible for rewards
  // *** ONLY OWNER ***
  function checkWinners() public {

    for(uint32 i = 0; i < ticketsArray.length; i++) {
      uint8 matching = 0;

      for(uint8 j = 0; j < ticketsArray[i].length; j++) {

        for(uint k = 0; k < winningArray.length; k++) {
          if(winningArray[k] == ticketsArray[i][j]) {
            matching = matching + 1;
          }
        }
      }

      if(matching == 6) {
        sixWinners.push(ticketOwnersArray[i]);
      } else if(matching == 5) {
        fiveWinners.push(ticketOwnersArray[i]);
      } else if(matching == 4) {
        fourWinners.push(ticketOwnersArray[i]);
      } else if(matching == 3) { 
        threeWinners.push(ticketOwnersArray[i]);
      }
    }
  }


  // admin can restart the game
  // *** ONLY OWNER ***
  function resetGame() public {

    rangeArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36];
    ticketId = 0;

    delete ticketsArray;
    delete ticketOwnersArray;
    delete winningArray;

    delete sixWinners;
    delete fiveWinners;
    delete fourWinners;
    delete threeWinners;
  }



  // ===================================================
  //               MODIFIERS - REQUIREMENTS
  // ===================================================


  // Only owner is allowed to call function
  modifier onlyOwner() {
    require(msg.sender == owner, "You are not an owner");
    _;
  }


  // User must pay lottery ticket price
  modifier payTicketPrice() {
    require(msg.value == ticketPrice, "Incorrect value");
    _;
  }










}