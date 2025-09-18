/// SPDX-License-Identifier: MIT 
pragma solidity 0.8.30;

/* 
 * @title Contrato Mensaje 
 * @author Diego Bruno - SaltaLbasII 
 * @notice Este contrato es parte del primer proyecto del Ethereum Developer Pack 
 * @custom:security Este es un contrato educativo y no debe ser usado en producción 
 */ 

contract Mensaje {
	//variable de estado : accesitble desde fuera del contrato
	///@notice variable para almacenar mensajes
	string s_mensaje;
	
	//eventos 
	///@notice evento emitido cuando el mensaje es actualizado
	event Mensaje_MensajeActualizado(string mensaje);
	
	//Funcionez
	/*
		@notice Función utilizada para almacenar un mensaje en la blockchain
		@param _mensaje entrada del tipo string
	*/
	function setMensaje(string memory _mensaje) external  {
		s_mensaje = _mensaje;
		
		emit Mensaje_MensajeActualizado(_mensaje);
	}

	/**
		*@notice función get para devolver el mensaje almacenado
		*@return _mensaje almacenado
	*/
	function getMensaje() public view returns(string memory _mensaje){
		_mensaje = s_mensaje;
	}
}