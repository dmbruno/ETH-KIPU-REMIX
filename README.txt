# ETH-KIPU REMIX

Este proyecto contiene **tres contratos inteligentes educativos** escritos en Solidity para la red Ethereum, pensados para aprender y experimentar con conceptos básicos de blockchain y desarrollo descentralizado.  
Cada contrato aborda un caso de uso distinto: mensajes, gestión de tareas y muro colaborativo de nombres.

---

## Tabla de contenidos

- [Descripción General](#descripción-general)
- [Contratos](#contratos)
  - [1. `Mensaje`](#1-mensaje)
  - [2. `ToDoList`](#2-todolist)
  - [3. `Wall`](#3-wall)
- [Uso en Remix](#uso-en-remix)
- [Despliegue a Testnet y Frontend](#despliegue-a-testnet-y-frontend)
- [Consideraciones de Seguridad](#consideraciones-de-seguridad)
- [Autores y Créditos](#autores-y-créditos)

---

## Descripción General

El repositorio incluye tres contratos:

- **Mensaje:** Guarda y recupera mensajes de texto.
- **ToDoList:** Permite crear y eliminar tareas, simulando una lista de pendientes.
- **Wall:** Muro colaborativo donde los usuarios pueden agregar su nombre solo una vez.

Todos los contratos están diseñados para ser simples y didácticos, ideales para practicar en Remix y desplegar a testnet (Sepolia, Goerli).

---

## Contratos

### 1. `Mensaje`

Contrato para almacenar un mensaje personalizado en la blockchain.

- **Funciones principales:**
  - `setMensaje(string _mensaje)`: Guarda un nuevo mensaje.
  - `getMensaje()`: Devuelve el mensaje actual.

- **Eventos:**
  - `Mensaje_MensajeActualizado(string mensaje)`: Se emite al actualizar el mensaje.

- **Uso típico:**  
  Ideal para aprender cómo guardar y leer información simple en la blockchain.

---

### 2. `ToDoList`

Contrato para gestionar una lista de tareas.

- **Estructura principal:**
  - `struct Tarea`: Cada tarea tiene descripción y fecha de creación.

- **Funciones principales:**
  - `setTarea(string _descripcion)`: Añade una nueva tarea.
  - `eliminarTarea(string _descripcion)`: Elimina una tarea por descripción.
  - `getTarea()`: Devuelve todas las tareas actuales.

- **Eventos:**
  - `ToDoList_TareaAnadida(Tarea tarea)`: Se emite al agregar tarea.
  - `ToDoList_TareaCompletadaYEliminada(string descripcion)`: Se emite al eliminar tarea.

- **Uso típico:**  
  Simula un gestor de pendientes. Permite practicar arrays, structs y eventos.

---

### 3. `Wall` (ETH-KIPU Wall)

Contrato colaborativo donde cada usuario puede agregar su nombre al muro solo una vez.

- **Variables principales:**
  - `string[] public names`: Array público de nombres.
  - `mapping(address => bool) public hasAdded`: Control para evitar duplicados por dirección.

- **Funciones principales:**
  - `addName(string name)`: Agrega nombre, solo una vez por dirección.
  - `getNames()`: Devuelve el array de nombres.
  - `count()`: Devuelve la cantidad actual de nombres.

- **Evento:**
  - `NameAdded(address indexed user, string name)`: Se emite al agregar nombre.

- **Uso típico:**  
  Ideal para crear muros colaborativos, listas de firmas, etc.

---

## Uso en Remix

1. Copia el contrato que quieras probar en un archivo `.sol` dentro de Remix IDE.
2. Compílalo con la versión `0.8.30` de Solidity.
3. Despliega en el entorno de pruebas (Remix VM) o con MetaMask en una testnet pública.
4. Interactúa con las funciones públicas y revisa los eventos.

---

## Despliegue a Testnet y Frontend

- Despliega el contrato en Sepolia/Goerli usando MetaMask.
- Copia la dirección del contrato y el ABI generado.
- Usa el ABI y dirección en dApps front-end (React, Ethers.js, Web3.js, etc.).
- ¡Puedes conectar tu frontend para mostrar mensajes, tareas o el muro colaborativo!

---

## Consideraciones de Seguridad

> **IMPORTANTE**:  
> Estos contratos son **educativos** y **no deben usarse en producción**.  
> No contemplan todas las medidas de seguridad necesarias para aplicaciones reales.

---

## Autores y Créditos

- **Diego Bruno** (SaltaLabsII) – Contrato `Mensaje`
- **i3arba - 77 Innovation Labs** – Contrato `ToDoList`
- **dmbruno y comunidad ETH-KIPU** – Contrato `Wall`

---

## Licencia

MIT – Uso libre y educativo.

---

**¿Quieres contribuir, mejorar los contratos o agregar más ejemplos? ¡Bienvenido!**
