var NatanAdmin = artifacts.require("./NatanAdmin.sol");
var NatanStudent = artifacts.require("./NatanStudent.sol");
var NatanTeacher = artifacts.require("./NatanTeacher.sol");
var Validator = artifacts.require("./Validator.sol");

async function doDeploy(deployer) {
    await deployer.deploy(NatanAdmin);
    await deployer.deploy(NatanStudent);
    await deployer.deploy(NatanTeacher);
    await deployer.deploy(Validator);
}

module.exports = (deployer) => {
    deployer.then(async() => {
        await doDeploy(deployer);
    });
}
