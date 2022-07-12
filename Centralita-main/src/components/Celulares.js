import React from "react";
import { useForm } from "../hooks/useForm";
import { Phone } from "./Phone";

export const Celulares = () => {
	const [values, handleInputChange] = useForm({
		searchText: "",
	});

	const { searchText } = values;

	const handleSearch = (e) => {
		e.preventDefault();
		console.log(searchText);
		// reset();
	};

	const repeticionPhone = () => {
		return <Phone />;
	};

	return (
		<div className="container">
			<form onSubmit={handleSearch}>
				<h3>Numero de telefonos</h3>
				<div className="">
					<input
						className="input"
						type="number"
						placeholder=""
						name="searchText"
						autoComplete="off"
						value={searchText}
						onChange={handleInputChange}
					/>

					<button className="btn btn-danger" type="submit">
						Agregar numero
					</button>
				</div>
			</form>

			<div id="Phones">
				<Phone nombre={"Telefono 1"} id={"11"} />
				<Phone nombre={"Centralita"} id={"12"} />
				<Phone nombre={"Telefono 2"} id={"13"} />
			</div>
		</div>
	);
};


/*
	if(submit == "12"){
		Generar evento de llamada
	}
	
	
	Generarse los eventos por id 

*/ 