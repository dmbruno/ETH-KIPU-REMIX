# Proyectos Solidity - ETH-KIPU Remix

Bienvenido/a a este repositorio, que recopila los principales proyectos prácticos desarrollados durante el Módulo 2 del curso Web3.  
Aquí encontrarás contratos inteligentes de complejidad creciente, con **foco principal en KipuBank**, y otros ejemplos educativos para practicar fundamentos de Solidity y desarrollo seguro en Ethereum.

---

## 🌟 Proyectos incluidos

### 1. KipuBank

**KipuBank** es el eje central de este repositorio. Es un contrato inteligente que simula una bóveda personal de ETH para cada usuario, con límites globales y por transacción, registro de eventos, contadores, seguridad y buenas prácticas.

#### Características principales:
- Depósitos y retiros de ETH con límites configurables.
- Límite global (`bankCap`) y máximo de retiro por transacción (`maxWithdrawalPerTx`), ambos inmutables.
- Contadores globales y por usuario de depósitos y retiros.
- Eventos claros para toda operación relevante.
- Seguridad: patrón checks-effects-interactions, control de reentrancy, errores personalizados en lugar de `require` string.
- Funciones para el owner (retiro y transferencia de propiedad).
- Recepción segura de ETH directo (`receive` y `fallback`) que **actualiza los balances y emite eventos**.
- **Función privada** para la lógica de depósito.
- Comentarios NatSpec y código limpio.
- **Atención:** El owner puede retirar el saldo total del contrato, incluidos fondos de otros usuarios. Los usuarios deben confiar en el owner.

#### Archivos:
- `contracts/kipu_bank.sol`

#### Despliegue e interacción:
- **Desplegar:** En Remix, setear valores para `bankCap` y `maxWithdrawalPerTx` en **wei** (1 ETH = 1000000000000000000).
- **Interactuar:** Usar las funciones `deposit`, `withdraw`, `getBalance`, `summary`, `ownerWithdrawFromBank`, `transferOwnership`.
- **Contrato desplegado y verificado:**
  - Dirección: [`0xfdde109C9fF886EA245B0E35e72805f5F36eAcC4`](https://sepolia.etherscan.io/address/0xfdde109C9fF886EA245B0E35e72805f5F36eAcC4)

---

### 2. Wall (ETH-KIPU Wall)

Un muro colaborativo donde cada dirección puede agregar su nombre exactamente una vez. Permite practicar arrays, mappings, eventos y restricciones de acceso simples.

#### Características:
- Cada usuario agrega un nombre al muro solo una vez.
- Consulta de todos los nombres y cantidad total.
- Eventos para cada nuevo nombre.

#### Archivos:
- `contracts/modulo2/muro.sol`

---

### 3. ToDoList

Un contrato para organizar tareas (to-dos) en la blockchain. Práctica de structs, arrays, eventos y manipulación de datos.

#### Características:
- Añadir tareas con timestamp.
- Eliminar tareas por descripción.
- Consultar todas las tareas almacenadas.
- Eventos de alta y baja de tareas.

#### Archivos:
- `contracts/modulo2/toDoList.sol`

---

### 4. Mensaje

Contrato simple para almacenar, actualizar y consultar un mensaje en la blockchain. Ideal para los primeros pasos en Solidity (storage, eventos, get/set).

#### Características:
- Setear y obtener un mensaje.
- Evento cuando se actualiza el mensaje.
- Práctica de variables de estado y funciones básicas.

#### Archivos:
- `contracts/modulo2/mensaje.sol`

---

## 🗂️ Estructura del repositorio

```
/contracts
│
├── kipu_bank.sol
│
└── modulo2/
    ├── mensaje.sol
    ├── muro.sol
    └── toDoList.sol
/scripts
/tests
README.md
```

---

## 📝 Instrucciones generales

1. Clona el repositorio o sube los archivos a [Remix](https://remix.ethereum.org/).
2. Compila el contrato que desees probar (asegúrate de tener la versión 0.8.30).
3. Despliega el contrato desde Remix.
    - Para KipuBank, configura los argumentos del constructor en **wei** (1 ETH = 1000000000000000000).
4. Interactúa con las funciones expuestas desde Remix o cualquier frontend compatible.
5. Consulta los eventos y el estado en la pestaña adecuada de Remix o en el explorador de bloques.

---

## ⚠️ Nota importante sobre KipuBank

> **¡Advertencia!**  
> El owner del contrato (quien lo despliega o recibe la propiedad) puede retirar el saldo total del banco, incluidos fondos de otros usuarios, usando la función `ownerWithdrawFromBank`.  
> Los usuarios deben confiar en el owner, ya que puede vaciar el contrato.

---

## 📚 Recursos útiles

- [Solidity Docs](https://docs.soliditylang.org/)
- [Remix IDE](https://remix.ethereum.org/)
- [Etherscan Sepolia](https://sepolia.etherscan.io/)
- [Blockscout Sepolia](https://eth-sepolia.blockscout.com/)

---

## ✍️ Autoría y créditos

- Contrato KipuBank: dmbruno ([github.com/dmbruno](https://github.com/dmbruno))
- Wall: dmbruno y comunidad ETH-KIPU
- ToDoList: i3arba - 77 Innovation Labs
- Mensaje: Diego Bruno - SaltaLabs

---

## 📝 Licencia

MIT