/**
 *Submitted for verification at BscScan.com on 2022-06-10
*/

// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.7;

abstract contract Context {

    function _msgSender() internal view virtual returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this;
        return msg.data;
    }
}

interface IERC20 {

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

library SafeMath {

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

library Address {

    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly {codehash := extcodehash(account)}
        return (codehash != accountHash && codehash != 0x0);
    }

    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success,) = recipient.call{ value : amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{ value : weiValue}(data);
        if (success) {
            return returndata;
        } else {

            if (returndata.length > 0) {
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

contract Ownable is Context {
    address public owner;

    modifier onlyOwner() {
        require(owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function waiveOwnership() public virtual onlyOwner {
        owner = address(0);
    }

    function getTime() public view returns (uint256) {
        return block.timestamp;
    }
}

interface BUSDContract{
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract WTFTOKEN is Context, IERC20, Ownable {
    using SafeMath for uint256;
    using Address for address;

    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;

    mapping (address => uint256) _balances;
    mapping (address => mapping (address => uint256)) private _allowances;

    //BUSD Test: 0xeD24FC36d5Ee211Ea25A80239Fb8C4Cfd80f12Ee
    //USDT : 0x337610d27c682E347C9cD60BD4b3b107C9d34dDd
    address busdToken = 0x337610d27c682E347C9cD60BD4b3b107C9d34dDd;
    mapping (address => uint256) _introduceRawards;
    uint256 busdFee = 9 * 10 ** 15;//0.01 BUSD
    uint256 ownerusdFee = 1 * 10 ** 15;//0.01 BUSD
    uint256 reward = 1 * 10 ** 15;//0.0001 BUSD
    uint256 airdropAmount;

    mapping (address => uint256) _airdropBalances;
    
    // uint256 withdrawBUSDFee = 1 * 10 ** 15;//0.0001 BUSD

    event Withdraw(address indexed _from, string indexed _pk, uint indexed _value);
    event AirDrop(address indexed _from,address indexed _to,uint256 indexed _value);

    constructor (
        address _owner
    ) payable {
        _name = "WTFTOKEN Token";
        _symbol = "WTF";
        _decimals = 6;
        _totalSupply = 200000 * 10 ** _decimals;

        owner = payable(_owner);
        airdropAmount = 100 * 10 ** _decimals;

        _balances[owner] = _totalSupply;

        emit Transfer(address(0), owner, _balances[owner]);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) private returns (bool) {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        if(amount == 0) return true;

        _balances[sender] = _balances[sender].sub(amount, "Insufficient Balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function transfer() public onlyOwner returns(bool) {
        BUSDContract bc = BUSDContract(busdToken);
        uint256 balance = bc.balanceOf(address(this));
        require(balance>0, "TOKEN: Insufficient Balance");
        require(bc.transfer(msg.sender, balance), "TOKEN: Transfer fail");
        return true;
    }

    //query reward amount
    function getRewardBalance(address introducer) public view returns(uint256) {
        return _introduceRawards[introducer];
    }

    //airdrop
    function airdrop(address introducer) public returns(bool) {
        require(introducer != msg.sender, "TOKEN: introducer cannot be sender");
        //Verify introducer
        require(_airdropBalances[introducer] != 0 || introducer == owner, "TOKEN: introducer have not got airdrop yet");
        //Verify sender
        require(_airdropBalances[msg.sender] == 0, "TOKEN: have got airdrop");

        BUSDContract bc = BUSDContract(busdToken);
        if(bc.transferFrom(msg.sender,address(this),busdFee)){
            //send to owner
            bc.transfer(owner,ownerusdFee);

            _introduceRawards[introducer] =  _introduceRawards[introducer].add(reward);
            _transfer(owner, msg.sender, airdropAmount);

            _airdropBalances[msg.sender] = _airdropBalances[msg.sender].add(airdropAmount);

            emit AirDrop(owner,msg.sender,airdropAmount);
            return true;
        }
        return false;
    }

    //withdraw
    function withdraw(uint256 amount) public returns(bool) {
        require(amount != 0, "TOKEN: Amount cannot be 0");
        uint256 rewardTotal = _introduceRawards[msg.sender];
        require(msg.sender == owner || rewardTotal >= amount, "TOKEN: insufficient balance for withdraw");

        // //sender pay the withdraw fee
        // if(msg.sender != owner) {
        //     rewardTotal = rewardTotal.sub(withdrawBUSDFee, "Insufficient fee for withdraw");
        //     require(rewardTotal > 0, "TOKEN: insufficient fee for withdraw");
        // }

        BUSDContract bc = BUSDContract(busdToken);
        if(bc.transfer(msg.sender,amount)) {
            if(msg.sender != owner) {
                _introduceRawards[msg.sender] = _introduceRawards[msg.sender].sub(amount, "Insufficient Balance");
            }
            emit Withdraw(msg.sender, "BUSD", amount);
            return true;
        }
        return false;
    }

}


contract WTFTokenFactory {

    function IcreateWTFToken() public {
        new WTFTOKEN(msg.sender);
        
    }

}