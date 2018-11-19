var NatanAdmin = artifacts.require("./NatanAdmin.sol");
var NatanLecture = artifacts.require("./NatanLecture.sol");
var Validator = artifacts.require("./utils/Validator.sol");

async function doDeploy(deployer) {
    await deployer.deploy(NatanAdmin);
    await deployer.deploy(NatanLecture);
    await deployer.deploy(Validator);
}

module.exports = (deployer) => {
    deployer.then(async() => {
        await doDeploy(deployer);
    });
}
