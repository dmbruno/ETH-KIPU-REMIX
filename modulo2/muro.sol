// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @title ETH-KIPU Wall - Un muro colaborativo de nombres en la blockchain.
/// @author dmbruno y comunidad ETH-KIPU
contract Wall {
    // Array público de nombres
    string[] public names;

    // Opcional: mapping para evitar duplicados por dirección
    mapping(address => bool) public hasAdded;

    // Evento emitido cuando se agrega un nombre
    event NameAdded(address indexed user, string name);

    /// @notice Agrega tu nombre al muro. Solo una vez por dirección.
    /// @param name El nombre a agregar
    function addName(string memory name) public {
        require(!hasAdded[msg.sender], "Ya agregaste tu nombre");
        names.push(name);
        hasAdded[msg.sender] = true;
        emit NameAdded(msg.sender, name);
    }

    /// @notice Devuelve todos los nombres agregados
    /// @return Un array de strings con los nombres
    function getNames() public view returns (string[] memory) {
        return names;
    }

    /// @notice Devuelve cuántos nombres hay en el muro
    function count() public view returns (uint) {
        return names.length;
    }
}