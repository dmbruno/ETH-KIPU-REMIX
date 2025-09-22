# ETH-KIPU-REMIX

Repositorio educativo con **tres contratos inteligentes en Solidity**: Mensaje, ToDoList y Wall.  
Cada uno demuestra funcionalidades básicas de Ethereum y está pensado para aprender desde cero.

---

## Contratos

### 1. Mensaje

**Descripción:**  
Permite guardar y consultar un mensaje de texto en la blockchain.

- **Funciones:**
  - `setMensaje(string)`: Guarda un mensaje.
  - `getMensaje()`: Retorna el mensaje guardado.

- **Evento:**  
  - `Mensaje_MensajeActualizado(string mensaje)`

---

### 2. ToDoList

**Descripción:**  
Gestor de tareas simple. Permite agregar y eliminar tareas, consultarlas y emite eventos.

- **Funciones:**
  - `setTarea(string)`: Agrega una tarea.
  - `eliminarTarea(string)`: Elimina una tarea por descripción.
  - `getTarea()`: Retorna todas las tareas.

- **Eventos:**  
  - `ToDoList_TareaAnadida(Tarea tarea)`  
  - `ToDoList_TareaCompletadaYEliminada(string descripcion)`

---

### 3. Wall (Muro ETH-KIPU)

**Descripción:**  
Muro colaborativo de nombres. Cada usuario puede agregar su nombre sólo una vez.

- **Funciones:**
  - `addName(string)`: Agrega tu nombre al muro.
  - `getNames()`: Devuelve el listado de nombres.
  - `count()`: Devuelve la cantidad de nombres.

- **Evento:**  
  - `NameAdded(address indexed user, string name)`

---

## Instrucciones de Despliegue

### 1. Usando **Remix IDE** (recomendado para principiantes)

1. Entra a [Remix](https://remix.ethereum.org/).
2. Crea un archivo `.sol` y pega el contrato que quieras desplegar.
3. Selecciona compilador Solidity versión **0.8.30**.
4. Compila el contrato.
5. Selecciona "Injected Provider - MetaMask" en la pestaña **Deploy & Run**.
6. Elige la red de testnet (por ejemplo, Sepolia).
7. Haz click en **Deploy**.
8. Guarda la dirección del contrato desplegado.

---

### 2. Opcional: Deploy desde Hardhat/truffle

> Este proyecto está pensado para Remix, pero puedes adaptarlo fácilmente a Hardhat o Truffle siguiendo sus tutoriales.

---

## Cómo interactuar con los contratos

### Usando **Remix**

1. Ve a la sección "Deployed Contracts".
2. Despliega las funciones y prueba:
   - En **Mensaje**: escribe un mensaje y ejecútalo, luego consulta el mensaje.
   - En **ToDoList**: agrega tareas, elimínalas por descripción, consulta el array.
   - En **Wall**: agrega tu nombre (sólo una vez por dirección), consulta listado y cantidad.

3. Observa los **eventos** en la pestaña "Logs" o "Transacciones" de Remix.

---

### Usando **Frontend/Web3 (React, Ethers.js, Web3.js)**

1. Copia la **dirección del contrato** y el **ABI** generado tras el deploy.
2. Usa una librería como [ethers.js](https://docs.ethers.org/) para conectarte al contrato desde tu dApp.
3. Ejemplo de interacción (con ethers.js):
   ```js
   import { Contract, BrowserProvider } from "ethers";
   const provider = new BrowserProvider(window.ethereum);
   const contrato = new Contract(CONTRACT_ADDRESS, ABI, provider);
   const mensaje = await contrato.getMensaje();
   ```
4. Asegúrate de tener MetaMask en la misma red que el deploy.

---

## Recomendaciones de seguridad

> **Estos contratos son solo para fines educativos. No los uses en producción.**

---

## Autores

- Diego Bruno (SaltaLabsII): Mensaje
- i3arba - 77 Innovation Labs: ToDoList
- dmbruno & comunidad ETH-KIPU: Wall

---

¿Dudas, sugerencias o mejoras?  
¡Contribuye o abre un issue!
