# KipuBank

Contrato inteligente de bóveda bancaria simple, desarrollado como proyecto práctico para el Módulo 2 del curso Web3. Permite a los usuarios depositar y retirar tokens nativos (ETH) bajo límites seguros, aplicando buenas prácticas de Solidity y seguridad.

---

## 🚀 Descripción

KipuBank es un contrato inteligente en Solidity que simula una caja de ahorro/“banco” personal para cada usuario en la red de Ethereum.  
Permite depósitos y retiros de ETH respetando un tope máximo global y un monto máximo de retiro por transacción.  
El contrato está pensado con seguridad y claridad para ser base de futuros proyectos y prácticas.

---

## ✨ Características principales

- Depósitos de ETH en una bóveda personal.
- Retiros de ETH respetando un límite máximo por operación.
- Límite global de fondos en el banco (`bankCap`).
- Contadores de depósitos y retiros globales y por usuario.
- Eventos en cada operación relevante.
- Errores personalizados para revertir con mensajes claros.
- Funciones de consulta de balance y resumen global.
- Función para que el owner retire fondos del banco.
- Recepción de ETH directo vía `receive()` y `fallback()`.
- Seguridad: patrón checks-effects-interactions, control de reentrancy, variables inmutables y bien comentadas, código limpio.

---

## 🛠️ Estructura del proyecto

```
/contracts
  └── KipuBank.sol
/README.md
```

---

## 📝 Ejemplo de uso

### Desplegar

1. Abre [Remix](https://remix.ethereum.org/).
2. Carga el archivo `KipuBank.sol` en la carpeta `/contracts`.
3. Compila el contrato con Solidity `0.8.30` (o compatible).
4. Despliega usando dos argumentos enteros en _wei_:
   - `bankCap`: Límite global de la bóveda (ejemplo: 1 ETH = `1000000000000000000`)
   - `maxWithdrawalPerTx`: Límite máximo de retiro por transacción (ejemplo: 1 ETH = `1000000000000000000`)

### Interactuar

- **deposit()**: Enviar ETH al banco.  
- **withdraw(uint256 amount)**: Retirar hasta el máximo permitido en una sola transacción.
- **getBalance(address user)**: Consultar el saldo de cualquier usuario.
- **summary()**: Consultar el estado global del banco.
- **ownerWithdrawFromBank(uint256 amount)**: El owner puede retirar fondos del banco general.
- **transferOwnership(address newOwner)**: Cambiar el owner.

### Recibir ETH directo

Puedes enviar ETH directamente al contrato (sin llamar a deposit) y será sumado al balance global (pero NO al balance personal).

---

## 🔒 Seguridad y buenas prácticas

- Uso de errores personalizados (`error MiError(...)`) en vez de `require` con string.
- Checks-effects-interactions y protección contra reentrancy.
- Modificadores `onlyOwner`, `nonReentrant` y validaciones de argumentos.
- Variables inmutables y constantes para límites.
- Comentarios NatSpec explicativos en cada función, variable y error.
- Nombres claros y consistentes.

---

## 📄 Ejemplo de despliegue

- **Dirección del contrato desplegado (Sepolia):**  
  `0xTuContratoEnSepolia`
- **Verificado en:**  
  [Etherscan Sepolia](https://sepolia.etherscan.io/address/0xTuContratoEnSepolia)

---

## 🧑‍💻 Interfaz/Frontend

Este repo solo contiene el contrato Solidity.  
Puedes ver la interfaz React que interactúa con este contrato en el repo:  
[ETH-KIPU-REMIX-frontend](https://github.com/dmbruno/ETH-KIPU-REMIX-frontend)

---

## 📚 Recursos útiles

- [Solidity Docs](https://docs.soliditylang.org/)
- [Remix IDE](https://remix.ethereum.org/)
- [Etherscan Sepolia](https://sepolia.etherscan.io/)

---

## 👨‍🎓 Autor

- Bruno Della Marca – [github.com/dmbruno](https://github.com/dmbruno)

---

## 📝 Licencia

MIT
