const TestKoksalToken = artifacts.require("TestKoksalToken");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("TestKoksalToken", function (/* accounts */) {
  it("should assert true", async function () {
    await TestKoksalToken.deployed();
    return assert.isTrue(true);
  });
});
