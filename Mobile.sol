pragma solidity ^0.4.6;
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
=> Mobile Interexchange Platform to be created for each SIM provider.
*/


contract ContractTermination{

	address public owner;

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
}

contract MyUserName is ContractTermination{

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
		_providerAddress.send(services[msg.sender]._debt);
	}
	
	function unsubscribe(address _providerAddress){
		if(services[_providerAddress].debt == 0){
			services[_providerAddress].active = false;

			}else{
				throw;
			}
	}


}

contract MobileProvider is ContractTermination{

	string public MobileProvider;
	string public operator;
	string public pwlan;
	string public utilitybill;
	
	function MobileProvider(
		string _UserId,
		string _operator,
		string _pwlanOffer,
		string _PayMyUtilityBill){

		MobileProvider = _UserId;
		operator  = _operator;
		pwlan  = _pwlanOffer;
		utilitybill  = _PayMyUtilityBill;

	}

	function setDebt(uint256 _debt, address _userAddress){

		MyUserName imediation = MyUserName(_userAddress);
		imediation.setDebt(_debt);

	}


}
