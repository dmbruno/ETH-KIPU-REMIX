// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @title KipuBank - Banco simple para depósitos y retiros de ETH con límites y seguridad
contract KipuBank {
    // ----------------- ERRORES -----------------
    /// @notice Solo el owner puede ejecutar esta función
    error NotOwner(address caller);
    /// @notice No se puede enviar ni retirar 0 ETH
    error ZeroAmount();
    /// @notice El depósito supera el límite global del banco
    error ExceedsBankCap(uint256 attempted, uint256 bankCap);
    /// @notice El monto excede el retiro máximo por transacción
    error ExceedsMaxWithdrawal(uint256 attempted, uint256 maxAllowed);
    /// @notice El usuario no tiene suficiente saldo para esta acción
    error InsufficientBalance(uint256 available, uint256 required);
    /// @notice Falló la transferencia de ETH
    error TransferFailed(address to, uint256 amount);
    /// @notice Se detectó un intento de reentrancia
    error ReentrantCall();

    // ----------------- CONSTANTES -----------------
    /// @notice Versión del contrato
    string public constant VERSION = "KipuBank v1";
    /// @notice Límite máximo de ETH que puede tener el banco
    uint256 public immutable bankCap;
    /// @notice Máximo que se puede retirar por transacción
    uint256 public immutable maxWithdrawalPerTx;

    // ----------------- VARIABLES -----------------
    /// @notice Dirección del dueño del contrato
    address public owner;
    /// @notice Balance global del banco
    uint256 public totalBankBalance;
    /// @notice Contador global de depósitos
    uint256 public totalDepositsCount;
    /// @notice Contador global de retiros
    uint256 public totalWithdrawalsCount;

    /// @notice Balance de cada usuario
    mapping(address => uint256) private balances;
    /// @notice Cantidad de depósitos por usuario
    mapping(address => uint256) public userDepositsCount;
    /// @notice Cantidad de retiros por usuario
    mapping(address => uint256) public userWithdrawalsCount;

    // ----------------- EVENTOS -----------------
    /// @notice Se emite al depositar ETH
    event Deposit(address indexed user, uint256 amount, uint256 newBalance, uint256 depositIndex);
    /// @notice Se emite al retirar ETH
    event Withdrawal(address indexed user, uint256 amount, uint256 newBalance, uint256 withdrawalIndex);
    /// @notice Se emite cuando el owner retira del banco
    event OwnerWithdrawal(address indexed owner, uint256 amount, uint256 bankBalanceAfter);

    // ----------------- REENTRANCY -----------------
    /// @dev Estado para control de reentrancy
    uint8 private _status;
    /// @dev Valor por defecto para control de reentrancy
    uint8 private constant _NOT_ENTERED = 1;
    /// @dev Valor de entrada para control de reentrancy
    uint8 private constant _ENTERED = 2;

    /// @notice Evita ataques de reentrancy
    modifier nonReentrant() {
        if (_status == _ENTERED) revert ReentrantCall();
        _status = _ENTERED;
        _;
        _status = _NOT_ENTERED;
    }

    /// @notice Solo deja ejecutar si es el dueño
    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner(msg.sender);
        _;
    }

    /// @notice Constructor, setea límites e inicializa el owner
    /// @param _bankCap Límite máximo de ETH del banco
    /// @param _maxWithdrawalPerTx Máximo retiro por transacción
    constructor(uint256 _bankCap, uint256 _maxWithdrawalPerTx) {
        owner = msg.sender;
        bankCap = _bankCap;
        maxWithdrawalPerTx = _maxWithdrawalPerTx;
        _status = _NOT_ENTERED;
    }

    // ----------------- FUNCIONES USUARIO -----------------
    /// @notice Deposita ETH en la bóveda personal
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

    /// @notice Retira ETH de la bóveda personal respetando los límites
    /// @param amount Cantidad a retirar en wei
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
    /// @notice Permite al owner retirar del banco
    /// @param amount Monto a retirar
    function ownerWithdrawFromBank(uint256 amount) external onlyOwner nonReentrant {
        if (amount == 0) revert ZeroAmount();
        if (amount > totalBankBalance) revert InsufficientBalance(totalBankBalance, amount);

        totalBankBalance -= amount;

        (bool sent, ) = msg.sender.call{value: amount}("");
        if (!sent) revert TransferFailed(msg.sender, amount);

        emit OwnerWithdrawal(msg.sender, amount, totalBankBalance);
    }

    /// @notice Cambia el owner del contrato
    /// @param newOwner Nueva dirección de owner
    function transferOwnership(address newOwner) external onlyOwner {
        if (newOwner == address(0)) revert NotOwner(newOwner);
        owner = newOwner;
    }

    // ----------------- FUNCIONES DE CONSULTA -----------------
    /// @notice Devuelve el balance de un usuario
    /// @param user Dirección a consultar
    /// @return Balance del usuario en wei
    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }

    /// @notice Devuelve el resumen global del banco
    /// @return bankBalance_ Balance total
    /// @return deposits_ Total de depósitos
    /// @return withdrawals_ Total de retiros
    /// @return cap_ Límite del banco
    /// @return maxWithdraw_ Límite de retiro por operación
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

    // ----------------- RECEIVE/FALLBACK -----------------
    /// @notice Permite recibir ETH directo al contrato (sin datos)
    receive() external payable {
        uint256 amount = msg.value;
        if (amount == 0) revert ZeroAmount();
        uint256 newTotal = totalBankBalance + amount;
        if (newTotal > bankCap) revert ExceedsBankCap(newTotal, bankCap);
        totalBankBalance = newTotal;
    }

    /// @notice Permite recibir ETH con datos no reconocidos
    fallback() external payable {
        if (msg.value > 0) {
            uint256 newTotal = totalBankBalance + msg.value;
            if (newTotal > bankCap) revert ExceedsBankCap(newTotal, bankCap);
            totalBankBalance = newTotal;
        }
    }
}