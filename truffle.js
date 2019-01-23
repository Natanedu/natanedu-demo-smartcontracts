const HDWalletProvider = require("truffle-hdwallet-provider");

require('dotenv').config()

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*", // Match any network id
    },
    ropsten: {
      provider: () => new HDWalletProvider(process.env.MNENOMIC, "https://ropsten.infura.io/" + process.env.INFURA_API_KEY),
      network_id: 3,
      gas: 4712388
      
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
};
