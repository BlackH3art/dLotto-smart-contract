# dLotto-smart-contract


Dapp is deployed on:\
https://meek-croissant-dcf6ea.netlify.app/

![](src/images/bg-thumbnail.png "thumbnail")

Application is deployed on Polygon Mumbai Testnet.

Lottery contract address:\
https://mumbai.polygonscan.com/address/0xae35dbfe8f33518e83bf52fb9eda623df006a86d

Frontend repo:\
https://github.com/BlackH3art/dLotto-frontend


-----

## dLotto
dLotto is decentralized lottery game where users are able to buy their Lottery Ticket to have chance for winning some cool rewards.\
With each ticket the user decides to buy, the user can select up to six numbers from the range between 1-36. User is able to win a reward if he will guess at least three out of six numbers that will be later randomly selected by Chainlink.\

One lottery ticket costs: `1 MATIC`
And rewards are as follows: 
 - 3 correct = **1.2 MATIC reward**
 - 4 correct = **5 MATIC reward**
 - 5 correct = **10 MATIC reward**
 - 6 correct = **PRIZE POOL reward**

Other rules:
1. Selected numbers must be unique.
2. User can buy as many tickets as he wants.
3. Prize pool will be equaly split between every user who  guessed all 6 numbers correctly.
4. 80% of the ticket price goes to Prize Pool, 20% is collected as protocol fee.

-----

### If you wanna try this app
1. Install metamask as an extension to your browser: https://metamask.io/
2. Create your wallet account (save your seed phrase)

3. You need to be connected to Polygon Mumbai, so add Mumbai network manually or vist:
    - https://chainlist.org/
    - include testnets
    - on the list of chains find Mumbai
    - connect wallet
    - and add Mumbai 
4. You will need some Mumbai MATIC tokens to pay for ticket and gas fees, head to this website, copy your address and request for tokens:
    - https://mumbaifaucet.com/
5. Now that you have some MATIC on your wallet, you good to go!

Clone repository:
```
git clone https://github.com/BlackH3art/dLotto-smart-contract.git
```

Then:
```
npm install
```

If you want deploy your own contract you will need to create `.env` file and fill it with variables:
```
PRIVATE_KEY="your private key here"
MUMBAI_RPC="your mumbai RPC here"
POLYGONSCAN_API="your polygonscan api key here"
```

After that you will have to create your own subscription at:
https://vrf.chain.link/mumbai
And fill it with Chainlink Tokens so you can pay fees for random numbers.

You will have to change `subscriptionId` at `scripts/deploy.js` at: 
```js
  const lottery = await Lottery.deploy(
    180, // subscription id
  );
```

As well as in `scripts/deployArguments` if you want to verify your contract on polygonscan:
```js
module.exports = [
  180 //subscription id
]
```

Console should print your contract address after running:
```
npx hardhat run scripts/deploy.js --network mumbai
```

And then console will print you full command to verify your contract.

----

