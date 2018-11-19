import utils from 'ethereumjs-util';

var Web3 = require('web3')

/**
 * Function to get web3 instance
 */
const getWeb3 = () => {
  const myWeb3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545"));
  return myWeb3;
}

/**
 * Hash and add same prefix to the hash that ganache use.
 * @param {string} message the plaintext/ascii/original message
 * @return {string} the hash of the message, prefixed, and then hashed again
 */
const hashMessage = (message) => {
  const messageHex = Buffer.from(utils.sha3(message).toString('hex'), 'hex');
  const prefix = utils.toBuffer('\u0019Ethereum Signed Message:\n' + messageHex.length.toString());
  return utils.bufferToHex(utils.sha3(Buffer.concat([prefix, messageHex])));
};

// signs message using web3 (auto-applies prefix)
/*const signMessage = (web3) => (signer, message = '') => {
  return web3.eth.sign(signer, web3.utils.sha3(message, {}));
};*/
const signMessage = (web3) => (_hash, _signer) => {
  const sig =  web3.personal.sign(_hash, _signer);
  console.log(sig);
  return sig;
};

// signs hex string using web3 (auto-applies prefix)
const signHex = (web3) => (signer, message = '') => {
  return web3.eth.sign(signer, web3.utils.sha3(message, { encoding: 'hex' }));
};

module.exports = {getWeb3, hashMessage, signMessage, signHex};
