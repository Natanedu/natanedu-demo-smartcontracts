
# Natanedu Demo Contracts

This repository contains the Solidity smart contracts for [Natanedu](https://natanedu.org/).

It uses the [Truffle framework](http://truffleframework.com/) for some things.

The smart contracts are deployed on Ropsten testnet:

    NatanAdmin:   0x3CeDEFe5f164D43a80677aE674bBEF5a6cc7306b

    NatanLecture: 0x068D1d62f8e392457b0149Cb3f2e4C2ae6c56B5a

    Validator:    0xdDcF54333064319ce8bB8e301025f800d4fB387e

## Development

### Installation

    $ npm install

### Requirements

All requirements are defined in `package.json`.

Those can be installed globally for convenience:

  * [truffle framework](http://truffleframework.com): `npm install -g truffle`
  * [ganache](http://truffleframework.com/ganache): `npm install -g ganache-cli`

We use following solidity contract libraries:

  * [Open Zeppelin](https://github.com/OpenZeppelin/zeppelin-solidity)

For local development it is recommended to use
[ganache-cli](https://github.com/trufflesuite/ganache-cli) (or the [ganache
GUI](http://truffleframework.com/ganache/) to run a local development chain.
Using the ganache simulator no full Ethereum node is required.

We default to:

* port 7545 for development to not get in conflict with the default Ethereum
  RPC port.

Have a look at `ganache-cli` for more configuration options.

Run your ganache simulator before using Natanedu locally:

    $ npm run ganache (which is: ganache-cli -p 7545)

### Truffle console

Truffle comes with a simple REPL to interact with the Smart Contracts. Have a
look at the [documentation
here](http://truffleframework.com/docs/getting_started/console)

NOTE: There are promisses, have a look at the examples:

```javascript
Token.deployed().then(function(token) {
  token.totalSupply.call().then(function(value) {
    console.log(value.toString());
  })
});
```

Also please be aware of the differences between web3.js 0.2x.x and
[1.x.x](https://web3js.readthedocs.io/en/1.0/) - [web3
repo](https://github.com/ethereum/web3.js/)

## Contract Deployment

Truffle uses migration scripts to deploy contract to various networks. Have a
look at the `migrations` folder for those.  The Ethereum nodes for the
different networks need to be configured in `truffle.js`.

Run the truffle migration scripts:

    $ truffle deploy
    $ truffle deploy --network=<network config from truffle.js>

Truffle keeps track of already executed migration scripts. To reset the
migration use the `--reset` option

    $ truffle migrate --reset

Migration scripts can also be run from within `truffle console` or `truffle
develop`