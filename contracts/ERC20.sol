// SPDX-License-Identifier: GPL-3.0
import "./IERC20.sol";

pragma solidity 0.8.7;
contract ERC20 is IERC20 {

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    uint constant private MAX_UINT = 2**256 - 1;
    uint256 private totalSupply;
    string private name;
    string private symbol;
    uint8 private decimals;

    constructor (
    uint256 _initialAmount,
    string memory _tokenName,
    uint8 _decimalUnits,
    string memory _tokenSymbol
    )public {
        balances[msg.sender] = _initialAmount;
        totalSupply = _initialAmount;
        name = _tokenName;
        symbol = _tokenSymbol;
        decimals = _decimalUnits;
    }

    function balanceOf(address _owner) public view override returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender,uint256 _amount) public override returns (bool success) {
        allowances[msg.sender][_spender] = _amount;
        emit Approval(msg.sender,_spender,_amount);
        return true;
    }

    function allowance(address _owner,address _spender) public view override returns (uint256 remaining) {
        return allowances[_owner][_spender];
    }

    function totalSupplyAmount() public view override returns (uint256 totSupply) {
        return totSupply;
    }

    function transfer(address _to,uint256 _value) public override returns (bool success) {
        require(balances[msg.sender] >= _value, "Insufficient balance");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender,_to,_value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function transferFrom(address _from,address _to,uint256 _value) public override returns (bool success) {
        uint256 allowance = allowances[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value, "Insufficient allowed funds");
        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowance < MAX_UINT) {
            allowances[_from][msg.sender] -= _value;
        }
        emit Transfer(_from,_to,_value); //solhint-disable-line indent, no-unused-vars
        return true;
    }
}