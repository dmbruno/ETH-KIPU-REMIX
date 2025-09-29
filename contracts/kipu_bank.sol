// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract KipuBank {
    // ----------------- ERRORES -----------------
    error NotOwner(address caller); // si es el duenio o no del contrato
    error ZeroAmount(); // previene transacciones con 0 eth
    error ExceedsBankCap(uint256 attempted, uint256 bankCap); // verifica que las tx no sean superiores a la capacidad establecida
    error ExceedsMaxWithdrawal(uint256 attempted, uint256 maxAllowed); // verifrica maximo a retirar , tambien establecido al momento del deploy
    error InsufficientBalance(uint256 available, uint256 required); // verifica que haya saldo
    error TransferFailed(address to, uint256 amount);// error para tx fallida
    error ReentrantCall(); // previene ataques de reentrancy

    // ----------------- CONSTANTES -----------------
    string public constant VERSION = "KipuBank v1";
    uint256 public immutable bankCap; // Límite global del banco
    uint256 public immutable maxWithdrawalPerTx; // Límite por transacción

    // ----------------- VARIABLES -----------------
    address public owner; // Dueño del contrato
    uint256 public totalBankBalance; // Saldo total del banco
    uint256 public totalDepositsCount; // Depósitos totales
    uint256 public totalWithdrawalsCount; // Retiros totales

    mapping(address => uint256) private balances; // Balance de cada usuario
    mapping(address => uint256) public userDepositsCount; //cantidad de depositos
    mapping(address => uint256) public userWithdrawalsCount; // cantidad de retiros

    // ----------------- EVENTOS -----------------
    event Deposit(address indexed user, uint256 amount, uint256 newBalance, uint256 depositIndex);
    event Withdrawal(address indexed user, uint256 amount, uint256 newBalance, uint256 withdrawalIndex);
    event OwnerWithdrawal(address indexed owner, uint256 amount, uint256 bankBalanceAfter);

    // ----------------- REENTRANCY -----------------
    uint8 private _status;
    uint8 private constant _NOT_ENTERED = 1;
    uint8 private constant _ENTERED = 2;

    modifier nonReentrant() {
        if (_status == _ENTERED) revert ReentrantCall();
        _status = _ENTERED;
        _;
        _status = _NOT_ENTERED;
    }

    // ----------------- MODIFIER OWNER -----------------
    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner(msg.sender);
        _;
    }

    // ----------------- CONSTRUCTOR -----------------
    constructor(uint256 _bankCap, uint256 _maxWithdrawalPerTx) {
        owner = msg.sender;
        bankCap = _bankCap;
        maxWithdrawalPerTx = _maxWithdrawalPerTx;
        _status = _NOT_ENTERED;
    }

    // ----------------- FUNCIONES USUARIO -----------------
    function deposit() external payable nonReentrant {
        uint256 amount = msg.value;
        if (amount == 0) revert ZeroAmount();
        uint256 newTotal = totalBankBalance + amount;
        if (newTotal > bankCap) revert ExceedsBankCap(newTotal, bankCap);

        balances[msg.sender] += amount;
        totalBankBalance = newTotal;
        totalDepositsCount++;
        userDepositsCount[msg.sender]++;

        emit Deposit(msg.sender, amount, balances[msg.sender], totalDepositsCount);
    }

    function withdraw(uint256 amount) external nonReentrant {
        if (amount == 0) revert ZeroAmount();
        if (amount > maxWithdrawalPerTx) revert ExceedsMaxWithdrawal(amount, maxWithdrawalPerTx);

        uint256 userBal = balances[msg.sender];
        if (userBal < amount) revert InsufficientBalance(userBal, amount);

        balances[msg.sender] = userBal - amount;
        totalBankBalance -= amount;
        totalWithdrawalsCount++;
        userWithdrawalsCount[msg.sender]++;

        (bool sent, ) = msg.sender.call{value: amount}("");
        if (!sent) revert TransferFailed(msg.sender, amount);

        emit Withdrawal(msg.sender, amount, balances[msg.sender], totalWithdrawalsCount);
    }

    // ----------------- FUNCIONES OWNER -----------------
    function ownerWithdrawFromBank(uint256 amount) external onlyOwner nonReentrant {
        if (amount == 0) revert ZeroAmount();
        if (amount > totalBankBalance) revert InsufficientBalance(totalBankBalance, amount);

        totalBankBalance -= amount;

        (bool sent, ) = msg.sender.call{value: amount}("");
        if (!sent) revert TransferFailed(msg.sender, amount);

        emit OwnerWithdrawal(msg.sender, amount, totalBankBalance);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        if (newOwner == address(0)) revert NotOwner(newOwner);
        owner = newOwner;
    }

    // ----------------- FUNCIONES DE CONSULTA -----------------
    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }

    function summary()
        external
        view
        returns (
            uint256 bankBalance_,
            uint256 deposits_,
            uint256 withdrawals_,
            uint256 cap_,
            uint256 maxWithdraw_
        )
    {
        return (totalBankBalance, totalDepositsCount, totalWithdrawalsCount, bankCap, maxWithdrawalPerTx);
    }

    
}
