pragma solidity ^0.4.8;

/*
This creates a public contract in the Ethereum Blockchain. 
Experimental contract based on https://github.com/Shultzi/Solidity/blob/master/demo.sol
and partially rewritten by amisolution.
 This contract is intended for testing purposes, you are fully responsible for compliance with
present or future regulations of finance, communications and the 
universal rights of digital beings.
Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
For more information, please refer to <http://unlicense.org>
Challenges of setting contract:
=> Additional TimeFrame of Delivery required
=> Short Contract duration TimeFrame cannot be handled by large mobile carrier.
=> Service Provider Interexchange Platform to be created for each SIM provider.
*/


contract ContractDestruction{

	address public owner;
	uint ownerbalance; 		// TIP: uint is an alias for uint256. Ditto int and int256.

	function mortal(){

		owner = msg.sender;

	}

	modifier onlyOwner{
		if (msg.sender != owner){
			throw;
		}else{
			_;
		}
	}

	function kill() onlyOwner{

		suicide(owner);
	}
    
    function ownerBalanceChecker() public 
    {
        owner = msg.sender; 								 // msg is a global variable
        ownerbalance = owner.balance;
    }

	function getContractAddress() constant returns (address) 
	{
		return this;
	}

	function getOwnerBalanceOld() constant returns (uint)     // Will return the owner's balance AT THE TIME THIS CONTRACT WAS CREATED
	{
        return ownerbalance;
    }
    
    function getOwnerBalanceNow() constant returns (uint)  // Will return owner's balance NOW
    {
        return owner.balance;
    }
}

contract MyUserName is ContractDestruction{

	string public userName;

	mapping(address=>Service) public services;

	struct Service{
		bool active;
		uint lastUpdate;
		uint256 debt;
	}

	function MyUserName(string _name){

		userName = _name;
	}

	function registerToProvider(address _providerAddress) onlyOwner {

		services[_providerAddress] = Service({
			active: true,
			lastUpdate: now,
			debt: 0
			});

	}

	function setDebt(uint256 _debt){
		if(services[msg.sender].active){
			services[msg.sender].lastUpdate = now;
			services[msg.sender].debt 		= _debt;

			}else{
				throw;
			}
	}
	
	function payToProvider(uint256 _debt, address _providerAddress){
		if (!_providerAddress.send(services[msg.sender].debt))
		    throw;
	}
	
	function unsubscribe(address _providerAddress){
		if(services[_providerAddress].debt == 0){
			services[_providerAddress].active = false;

			}else{
				throw;
			}
	}


}

contract ServiceProvider is ContractDestruction{

	string public ServiceProvider;
	string public operator;
	string public cellbill;
	string public utilitybill;
	
	function ServiceProvider(
		string _UserId,
		string _operator,
		string _PayMyCellBill,
		string _PayMyUtilityBill){

		ServiceProvider = _UserId;
		operator  = _operator;
		cellbill  = _PayMyCellBill;
		utilitybill  = _PayMyUtilityBill;

	}

	function setDebt(uint256 _debt, address _userAddress){

		MyUserName imediation = MyUserName(_userAddress);
		imediation.setDebt(_debt);

	}

}

