const NatanAdmin = artifacts.require("NatanAdmin");
const NatanLecture = artifacts.require("NatanLecture");
const NatanStudent = artifacts.require("NatanStudent");
const NatanTeacher = artifacts.require("NatanTeacher");

const logTitle = function (title) {
  console.log("*****************************************");
  console.log(title);
  console.log("*****************************************");
}

const logError = function (err) {
  console.log("-----------------------------------------");
  console.log(err);
  console.log("-----------------------------------------");
}

contract('Natan Demo Smart Contracts', (accounts) => {

    let natanAdminContract;
    let natanStudentContract;
    let natanTeacherContract;
    let natanLectureContract;

    before(async() => {
        admin = accounts[0];
        teacher1 = accounts[1];
        student1 = accounts[2];
        student2 = accounts[3];

        natanAdminContract = await NatanAdmin.new({from: admin});
        natanStudentContract = await NatanStudent.new({from: admin});
        natanTeacherContract = await NatanTeacher.new({from: admin});
        natanLectureContract = await NatanLecture.new({from: admin});
    });

    describe("Add/Remove admins", async () => {

        it("Assign new admin", async () => {
            await natanAdminContract.addAdmin(accounts[4], {from: admin});
            natanAdminContract.owners(accounts[4]).then((res) => {
                assert.equal(res, true);
            });
        });

        it("Remove admin", async () => {
            await natanAdminContract.removeAdmin(accounts[4], {from: admin});
            natanAdminContract.owners(accounts[4]).then((res) => {
                assert.equal(res, false);
            });
        });

        it('should FAIL to assign new admin from unauthorized address', async() => {
            try {
                await natanAdminContract.addAdmin(accounts[4], {from: accounts[9]});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to assign new admin with invalid address', async() => {
            try {
                await natanAdminContract.addAdmin(0, {from: admin});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to remove admin from unauthorized address', async() => {
            try {
                await natanAdminContract.removeAdmin(accounts[4], {from: accounts[9]});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to remove admin with invalid address', async() => {
            try {
                await natanAdminContract.removeAdmin(0, {from: admin});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to remove non existant admin', async() => {
            try {
                await natanAdminContract.removeAdmin(accounts[5], {from: admin});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

    });

    describe("Whitelist/Blacklist students", async () => {

        it("Whitelist a student", async () => {
            await natanStudentContract.whiteList(student1, {from: admin});
            natanStudentContract.whiteListed(student1).then((res) => {
                assert.equal(res, true);
            });
        });

        it("Blacklist a student", async () => {
            await natanStudentContract.blackList(student1, {from: admin});
            natanStudentContract.blackListed(student1).then((res1) => {
                natanStudentContract.whiteListed(student1).then((res2) => {
                    assert.equal(res1, true);
                    assert.equal(res2, false);
                });
            });
        });

        it('should FAIL to whitelist a student from unauthorized address', async() => {
            try {
                await natanAdminContract.whiteList(student1, {from: accounts[9]});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to whitelist student with invalid address', async() => {
            try {
                await natanAdminContract.whiteList(0, {from: admin});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to blacklist a student from unauthorized address', async() => {
            try {
                await natanAdminContract.blackList(student1, {from: accounts[9]});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to blacklist student with invalid address', async() => {
            try {
                await natanAdminContract.blackList(0, {from: admin});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to blacklist student that is not whitelisted', async() => {
            try {
                await natanAdminContract.blackList(student2, {from: admin});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

    });

});