# ETH-KIPU-REMIX

## Descripción breve

Este repositorio contiene dos contratos inteligentes desarrollados en Solidity para la red Ethereum Sepolia, como parte del Ethereum Developer Pack. El objetivo es demostrar la creación, despliegue y verificación de smart contracts simples desde Remix IDE.

### Contratos incluidos

- **mensaje.sol:**  
  Permite almacenar y actualizar un mensaje en la blockchain. Es ideal como ejemplo básico de interacción con variables de estado y eventos en Solidity.

- **toDoList.sol:**  
  Implementa una lista de tareas (to-do list) donde los usuarios pueden agregar, consultar y completar tareas en la blockchain. Este contrato sirve para demostrar operaciones con arrays, estructuras y funciones públicas.

---

## ¿Cómo clonar y ejecutar el proyecto en un IDE?

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/dmbruno/ETH-KIPU-REMIX.git
   ```

2. **Abrir el proyecto en Remix IDE**
   - Accede a [Remix IDE](https://remix.ethereum.org).
   - Carga los archivos `mensaje.sol` y `toDoList.sol` en Remix.
   - Compila cada contrato con la versión de Solidity indicada en sus archivos.
   - Configura el entorno de deploy (por ejemplo, “Injected Provider - MetaMask” en la red Sepolia).

3. **Desplegar los contratos**
   - Selecciona el contrato que deseas desplegar en “Deploy & Run Transactions”.
   - Haz deploy y copia la dirección del contrato.

---

## Enlaces de acceso a los contratos en Block Explorer (Sepolia Etherscan)

- [`mensaje.sol` en Sepolia Etherscan](https://sepolia.etherscan.io/address/0x41C9E1911951c5f7F1f5505833461D485985C8e0)
- [`toDoList.sol` en Sepolia Etherscan](https://sepolia.etherscan.io/address/0x085f4bC29269BdB7144031Ec1D861b9eF3cfFDe9)

---

