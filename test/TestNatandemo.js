const NatanAdmin = artifacts.require("NatanAdmin");
const NatanLecture = artifacts.require("NatanLecture");

const BigNumber = require('bignumber.js');

const logTitle = (title) => {
  console.log("*****************************************");
  console.log(title);
  console.log("*****************************************");
}

const logError = (err) => {
  console.log("-----------------------------------------");
  console.log(err);
  console.log("-----------------------------------------");
}

contract('Natan Demo Smart Contracts', (accounts) => {

    let natanAdminContract;
    let natanLectureContract;

    let admin;
    let teacher1;
    let student1;
    let student2;

    before(async() => {
        admin = accounts[0];
        teacher1 = accounts[1];
        student1 = accounts[2];
        student2 = accounts[3];

        natanAdminContract = await NatanAdmin.new({from: admin});
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

    describe("Register student", async () => {

        it("student sign in", async () => {
            await natanLectureContract.registerStudent(student1, "student1", "student1");
            natanLectureContract.listedStudents(student1).then((res) => {
                assert.equal(res.toNumber(), 3);
            });
        });

        it('should FAIL to sign in if already registered', async() => {
            try {
                await natanLectureContract.registerStudent(student1, "student1", "student1");
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to sign in with invalid address', async() => {
            try {
                await natanLectureContract.registerStudent(0, "student1", "student1");
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });
    });

    describe("Whitelist/Blacklist student", async () => {

        it("Blacklist a student", async () => {
            await natanLectureContract.blackListStudent(student1, {from: admin});
            natanLectureContract.listedStudents(student1).then((res) => {
                assert.equal(res, 1);
            });
        });

        it("Whitelist a student", async () => {
            await natanLectureContract.whiteListStudent(student1, {from: admin});
            natanLectureContract.listedStudents(student1).then((res) => {
                assert.equal(res, 3);
            });
        });

        it('should FAIL to whitelist a student from unauthorized address', async() => {
            try {
                await natanLectureContract.whiteListStudent(student1, {from: accounts[9]});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to whitelist student with invalid address', async() => {
            try {
                await natanLectureContract.whiteListStudent(0, {from: admin});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to blacklist a student from unauthorized address', async() => {
            try {
                await natanLectureContract.blackListStudent(student1, {from: accounts[9]});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to blacklist student with invalid address', async() => {
            try {
                await natanLectureContract.blackListStudent(0, {from: admin});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to blacklist student that is not whitelisted', async() => {
            try {
                await natanLectureContract.blackListStudent(student2, {from: admin});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

    });

    describe("Register teacher", async () => {

        it("teacher sign in", async () => {
            await natanLectureContract.registerTeacher(teacher1, "teacher1", "teacher1", "region1", "topic1", "lang1", 1, 10);
            natanLectureContract.listedTeachers(teacher1).then((res) => {
                assert.equal(res.toNumber(), 3);
            });
        });

        it('should FAIL to sign in if already registered', async() => {
            try {
                await natanLectureContract.registerTeacher(teacher1, "teacher1", "teacher1", "region1", "topic1", "lang1", 1, 10);
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to sign in with invalid address', async() => {
            try {
                await natanLectureContract.registerTeacher(0, "teacher1", "teacher1", "region1", "topic1", "lang1", 1, 10);
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it("shoulg get teacher informations", async () => {
            await natanLectureContract.teachers(teacher1).then((res) => {
                assert.notStrictEqual(res, undefined);
            });
        });
    });

    describe("Whitelist/Blacklist teacher", async () => {

        it("Blacklist a teacher", async () => {
            await natanLectureContract.blackListTeacher(teacher1, {from: admin});
            natanLectureContract.listedTeachers(teacher1).then((res) => {
                assert.equal(res, 1);
            });
        });

        it("Whitelist a teacher", async () => {
            await natanLectureContract.whiteListTeacher(teacher1, {from: admin});
            natanLectureContract.listedTeachers(teacher1).then((res) => {
                assert.equal(res, 3);
            });
        });

        it('should FAIL to whitelist a teacher from unauthorized address', async() => {
            try {
                await natanLectureContract.whiteListTeacher(teacher1, {from: accounts[9]});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to whitelist teacher with invalid address', async() => {
            try {
                await natanLectureContract.whiteListTeacher(0, {from: admin});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to blacklist a teacher from unauthorized address', async() => {
            try {
                await natanLectureContract.blackListTeacher(teacher, {from: accounts[9]});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to blacklist teacher with invalid address', async() => {
            try {
                await natanLectureContract.blackListTeacher(0, {from: admin});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

        it('should FAIL to blacklist teacher that is not whitelisted', async() => {
            try {
                await natanLectureContract.blackListTeacher(accounts[8], {from: admin});
            } catch (error) {
                return true;
            }
            throw new Error("I should never see this!")
        });

    });

    describe("Teachers filters", async() => {
        before(async() => {
            //list of teachers to add and whitelist
            teacher5 = accounts[5];
            teacher6 = accounts[6];
            teacher7 = accounts[7];
            teacher8 = accounts[8];
            teacher9 = accounts[9];

            await natanLectureContract.registerTeacher(teacher5, "teacher5", "teacher5", "region5", "Blockchain", "english", 1, 10);
            await natanLectureContract.registerTeacher(teacher6, "teacher6", "teacher6", "region6", "Blockchain", "english", 1, 10);
            await natanLectureContract.registerTeacher(teacher7, "teacher7", "teacher7", "region7", "Blockchain", "arabic", 1, 10);
            await natanLectureContract.registerTeacher(teacher8, "teacher8", "teacher8", "region8", "AI", "spanish", 1, 10);
            await natanLectureContract.registerTeacher(teacher9, "teacher9", "teacher9", "region9", "AI", "spanish", 1, 10);
        });

        it("Get number of teachers", async () => {
            let teachersNumber = await natanLectureContract.getTeachersCount();
            assert.equal(teachersNumber.toNumber(), 6);
        });

        it("Get all teachers", async () => {
            let retreivedTeachers = [];
            let teachersNumber = await natanLectureContract.getTeachersCount();
            for(i=0; i<teachersNumber; i++) {
                let teacherAddress = await natanLectureContract.teachersAddress(i);
                let teacher = await natanLectureContract.teachers(teacherAddress);
                retreivedTeachers.push(teacher);
            }
            assert.equal(retreivedTeachers.length, 6);
        });

        it("Get teachers by topic", async () => {
            let blockchainTopic = "Blockchain";
            let teachersByTopic = await natanLectureContract.getByTopic(blockchainTopic);

            let validAddressCounter = 0;
            for(let i = 0; i < teachersByTopic.length; i++) {
                if(teachersByTopic[i] != "0x0000000000000000000000000000000000000000") {
                    validAddressCounter++;
                }
            }
            assert(validAddressCounter, 3);
        });     
        
        it("Get teachers by language", async() => {
            let lang = "english";
            let teachersByLanguage = await natanLectureContract.getByLanguage(lang);

            let validAddressCounter = 0;
            for(let i = 0; i < teachersByLanguage.length; i++) {
                if(teachersByLanguage[i] != "0x0000000000000000000000000000000000000000") {
                    validAddressCounter++;
                }
            }
            assert(validAddressCounter, 2);
        });

        it("Get teachers by topic and language", async() => {
            let topic = "Blockchain"
            let lang = "arabic";
            let teachersByLanguage = await natanLectureContract.getByTopicLanguage(topic, lang);

            let validAddressCounter = 0;
            for(let i = 0; i < teachersByLanguage.length; i++) {
                if(teachersByLanguage[i] != "0x0000000000000000000000000000000000000000") {
                    validAddressCounter++;
                }
            }
            assert(validAddressCounter, 1);
        });
    });

    describe("Lecture", async () => {

        let lectureId = 0;
        let teacherBalance;
        
        it("generate lecture id", async () => {
            //generate lecture idlet
            await natanLectureContract.generateLectureId({from : student1});
            natanLectureContract.lecturesId.call().then((res) => {
                lectureId = res.toNumber();
                assert.equal(lectureId, 1);
            });
        });

        it("pay for lecture", async () => {
            let lecturePrice = web3.utils.toWei("2", "ether"); //in Wei
            let lectureId = await natanLectureContract.lecturesId.call();

            await natanLectureContract.payLecture(lectureId.toNumber(), lecturePrice, student1, teacher1, {from: student1, value: lecturePrice});            
            let contractBalance = await web3.eth.getBalance(natanLectureContract.address);
            teacherBalance = await natanLectureContract.teacherBalance(teacher1);

            assert.equal(contractBalance, lecturePrice);
            
            let percentage = new BigNumber(Math.round(lecturePrice-((lecturePrice*3)/100)));
            assert.equal(percentage.isEqualTo(teacherBalance), true);
        });

        it("end lecture", async () => {
            await natanLectureContract.transfer(teacher1);   
            let teacherWalletBalance = new BigNumber(await web3.eth.getBalance(teacher1));

            let teacherBalanceAfterTransfer = await natanLectureContract.teacherBalance(teacher1);
            assert.equal(teacherBalanceAfterTransfer.toString(), "0");
        });

    });

});