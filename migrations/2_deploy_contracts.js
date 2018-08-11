async function doDeploy(deployer) {
}

module.exports = (deployer) => {
    deployer.then(async() => {
        await doDeploy(deployer);
    });
}
