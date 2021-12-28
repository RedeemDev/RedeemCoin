 
// SPDX-License-Identifier: unidentified
//Polygon MATIC


pragma solidity 0.8.7;
interface IERC20 {
 
  function totalSupply() external view returns (uint256); 
  function decimals() external view returns (uint8); 
  function symbol() external view returns (string memory); 
  function name() external view returns (string memory);  
  function balanceOf(address account) external view returns (uint256); 
  function transfer(address recipient, uint256 amount) external returns (bool); 
  function allowance(address _owner, address spender) external view returns (uint256); 
  function approve(address spender, uint256 amount) external returns (bool); 
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool); 
  event Transfer(address indexed from, address indexed to, uint256 value); 
  event Approval(address indexed owner, address indexed spender, uint256 value);
} 

/**
 * @dev Collection of functions related to the address type
 */
library Address {
     
    function isContract(address account) internal view returns (bool) {
     
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
 
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
 
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }
 
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }
 
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }
 
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }
 
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }
 
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }
 
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

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

abstract contract Context {
  // Empty internal constructor, to prevent people from mistakenly deploying
  // an instance of this contract, which should be used via inheritance.
  constructor ()  { }

  function _msgSender() internal view virtual returns  (address payable) {
    return payable (msg.sender);
  }

  function _msgData() internal view virtual returns  (bytes memory) {
    this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
    return msg.data;
  }
} 

library SafeMath { 
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    } 
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    } 
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked { 
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    } 
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    } 
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    } 
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    } 
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    } 
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    } 
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    } 
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    } 
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    } 
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    } 
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}
 
contract Ownable is Context {
  address private _owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
 
  constructor ()  {
    address msgSender = _msgSender();
    _owner = msgSender;
    emit OwnershipTransferred(address(0), msgSender);
  }

  function owner() public view returns (address) {
    return _owner;
  } 
  modifier onlyOwner() {
    require(_owner == _msgSender(), "Ownable: caller is not the owner");
    _;
  }

  function renounceOwnership() public onlyOwner {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
  }

  function transferOwnership(address newOwner) public onlyOwner {
    _transferOwnership(newOwner);
  }

  function _transferOwnership(address newOwner) internal {
    require(newOwner != address(0), "Ownable: new owner is the zero address");
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
 
}

  contract  Redeem  is  Context, IERC20, Ownable  {
  using SafeMath for uint256;
  using Address for address;

  mapping (address => uint256) private _balances;  
  mapping (address => mapping (address => uint256)) private _allowances;
  mapping (address => bool) private _excludedFromFee; 

  uint256 private _totalSupply = 150 *10**6;
  uint8 public _decimals = 0;
  string public _symbol = "RDM";
  string public _name = "Redeem"; 

  uint256 public _liquidityFee = 2;
  uint256 private _previousLiquidityFee = _liquidityFee;
  
  IUniswapV2Router02 public immutable uniswapV2Router;
  address public immutable uniswapV2Pair;

  bool swappingForLiquidity;
  bool public swapAddLiquidityAllowed = true; 
     
  uint256 private redeemReqToAddLiquidity = 5 * 10**6;
  
  event TokensForLiquidity(uint256 tokens);
  event MinTokensBeforeSwapUpdated(uint256 redeemReqToAddLiquidity); 
  event SwapAndLiquifyEnabledUpdated(bool enabled);
  event SwapAndLiquify(
        uint256 tokensSwapped,
        uint256 ethReceived,
        uint256 tokensIntoLiqudity
  );
  //Determines the state of the contracts liquiditySwap feature. 
  modifier preventMultSwaps {
        swappingForLiquidity = true;
        _;
        swappingForLiquidity = false;
  }

  constructor() { 

    _balances[msg.sender] = _totalSupply;

        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff);
        //0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678ff <-- Quickswap Router (Main)   
         // Create a uniswap pair for this new token
        uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory())
        .createPair(address(this), _uniswapV2Router.WETH());

        // set the rest of the contract variables
        uniswapV2Router = _uniswapV2Router;
        //Exclude Owner and this address from _liquidityFee
        _excludedFromFee[owner()] = true;
        _excludedFromFee[address(this)] = true; 
    emit Transfer(address(0), msg.sender, _totalSupply);

  } 
 
  function decimals() override public view returns (uint8) {
    return _decimals;
  }
 
  function symbol() override public view returns (string memory) {
    return _symbol;
  }
 
  function name() override public view returns (string memory) {
    return _name;
  }
 
  function totalSupply() override public view returns (uint256) {
    return _totalSupply;
  } 

  function balanceOf(address account)  public view override returns (uint256) { 
      return _balances[account]; 
  }
 
  function transfer(address recipient, uint256 amount) override public returns (bool) {
    _transfer(_msgSender(), recipient, amount);
    return true;
  }

  // Only Owner functions /////////////////////////////////////////////////////////////////////



  function excludeAddressFromFee(address account) public onlyOwner() { 
        require(!_excludedFromFee[account], "Account is already excluded");  
        _excludedFromFee[account] = true;
  }
 
  function setLiquidityFee(uint256 liquidityFee) public onlyOwner() {
        _liquidityFee = liquidityFee;
  }

  function setSwapAndLiquifyEnabled(bool _state) public onlyOwner() {
        swapAddLiquidityAllowed = _state;
        emit SwapAndLiquifyEnabledUpdated(_state);
  } 

  // Only Owner functions /////////////////////////////////////////////////////////////////////
 
  function allowance(address owner, address spender) override public view returns (uint256) {
    return _allowances[owner][spender];
  } 
  
  function approve(address spender, uint256 amount) override public returns (bool) {
    _approve(_msgSender(), spender, amount);
    return true;
  } 

  function transferFrom(address sender, address recipient, uint256 amount) override public returns (bool) {
    _transfer(sender, recipient, amount);
    _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
    return true;
  }
 
  function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
    return true;
  }
 
  function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
    return true;
  }
  
  function burn(uint256 amount) public returns (bool) {
    _burn(_msgSender(), amount);
    return true;
  }
  function _burn(address account, uint256 amount) internal {
    require(account != address(0), "ERC20: burn from the zero address");

    _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
    _totalSupply = _totalSupply.sub(amount);
    emit Transfer(account, address(0), amount);
  } 

  function _approve(address owner, address spender, uint256 amount) internal {
    require(owner != address(0), "ERC20: approve from the zero address");
    require(spender != address(0), "ERC20: approve to the zero address");

    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
  }
 
  function _burnFrom(address account, uint256 amount) internal {
    _burn(account, amount);
    _approve(account, _msgSender(), _allowances[account][_msgSender()].sub(amount, "ERC20: burn amount exceeds allowance"));
  }
  //to recieve from uniswapV2Router when swapping
  receive() external payable {}

  
  function _transfer(
    address sender, 
    address recipient, 
    uint256 amount
    ) private {
    require(sender != address(0), "ERC20: transfer from the zero address");
    require(recipient != address(0), "ERC20: transfer to the zero address");
    require(amount > 0, "Transfer amount must be greater than zero");

    uint256 redeemContractBalance = balanceOf(address(this)); 

    bool readyToAddLiquidity = redeemContractBalance >= redeemReqToAddLiquidity;

    if (
            readyToAddLiquidity &&
            !swappingForLiquidity &&
            sender != uniswapV2Pair &&
            swapAddLiquidityAllowed
        ) {
            redeemContractBalance = redeemReqToAddLiquidity;
            //add liquidity with RedeemReqToAddLiquidity
            swapAndLiquify(redeemContractBalance);
        }
        //begin by establishing need to deduct fee from transfer
        bool deductLiquidityFee = true; 
        //if either account belongs to _excludedFromFee account then remove the fee
        if(_excludedFromFee[sender] || _excludedFromFee[recipient]){
            deductLiquidityFee = false;
        }
         
      //transfer, it will take liquidity fee
        _continueTransfer(sender, recipient, amount, deductLiquidityFee);
  }

  function _continueTransfer(address sender, address recipient, uint256 amount, bool deductLiquidityFee) private {
        if(!deductLiquidityFee){
          zeroLiquidityFee();
        } 

        if(deductLiquidityFee){
           _transferWithFee(sender,recipient,amount);
        } else {
          _transferWithoutFee(sender,recipient,amount);
        } 

        if(!deductLiquidityFee){
        reinstateLiquidityFee();
        }
            
  }

  function _transferWithFee(address sender, address recipient, uint256 amount) private {
 
         uint256 redeemForLiquidity = calcTokensForLiquidity(amount);
         uint256 remainingRedeem = amount.sub(redeemForLiquidity, "Error occured at remainingRedeem sub"); 
         
        _balances[sender] = _balances[sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(remainingRedeem);
 
        _takeLiquidityTokens(redeemForLiquidity);
        emit Transfer(sender, recipient, remainingRedeem);
  }

  function _transferWithoutFee(address sender, address recipient, uint256 amount) private  { 
      

        _balances[sender] = _balances[sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount); 
        emit Transfer(sender, recipient,  amount);
  }

  function _takeLiquidityTokens(uint256 tokens) private {

        _balances[address(this)].add(tokens); 
        emit TokensForLiquidity(tokens); 
  }


  function calcTokensForLiquidity(uint256 amount) private view returns (uint256) {
        return amount.mul(_liquidityFee).div(10**2);
  } 

  function zeroLiquidityFee() private {
        if(_liquidityFee == 0) return;
        _previousLiquidityFee = _liquidityFee;
        _liquidityFee = 0;
  }
    
  function reinstateLiquidityFee() private {
        _liquidityFee = _previousLiquidityFee;
  }
 
  function swapAndLiquify(uint256 redeemContractBalance) private preventMultSwaps {
        // split the contract balance into halves
        uint256 half = redeemContractBalance.div(2);
        uint256 otherHalf = redeemContractBalance.sub(half);

        // capture redeem contracts current balance. 
        uint256 initialBalance = address(this).balance;

        // swap tokens for ETH
        swapTokensForEth(half); //  

        // how much ETH did we just swap into?
        uint256 newBalance = address(this).balance.sub(initialBalance);

        // add liquidity to uniswap
        addLiquidity(otherHalf, newBalance);
        
        emit SwapAndLiquify(half, newBalance, otherHalf);
    }

    function swapTokensForEth(uint256 tokenAmount) private {
        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();
        // approve token transfer to cover all possible scenarios
        _approve(address(this), address(uniswapV2Router), tokenAmount);

        // make the swap
        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of ETH
            path,
            address(this),
            block.timestamp
        );
    }

    function addLiquidity(uint256 tokenAmount, uint256 ethAmount) private {
        // approve token transfer to cover all possible scenarios
        _approve(address(this), address(uniswapV2Router), tokenAmount);

        // add the liquidity
        uniswapV2Router.addLiquidityETH{value: ethAmount}(
            address(this),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            owner(),
            block.timestamp
        );
    }
  
  
}
 

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}
 

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}
 

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}



// pragma solidity >=0.6.2;

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}
