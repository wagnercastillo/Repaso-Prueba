import React from "react";

export const Phone = ({ nombre, id }) => {
	return (
		<div>

			<div className="telefono">
				<h3>{nombre}</h3>
				<h5>{id}</h5>
				<div className="pantalla" id="pantalla">
					<div className="numero">
						<input type="tel" id="tel" pattern="[0-9]{10}" value="" />
					</div>
					<div className="teclado">
						<button type="submit" className="tecla"  onclick="numero('1')">1</button>
						<button type="submit" className="tecla"  onclick="numero('2')">2</button>
						<button type="submit" className="tecla"  onclick="numero('3')">3</button>
						<button type="submit" className="tecla"  onclick="numero('4')">4</button>
						<button type="submit" className="tecla"  onclick="numero('5')">5</button>
						<button type="submit" className="tecla"  onclick="numero('6')">6</button>
						<button type="submit" className="tecla"  onclick="numero('7')">7</button>
						<button type="submit" className="tecla"  onclick="numero('8')">8</button>
						<button type="submit" className="tecla"  onclick="numero('9')">9</button>
						<button type="submit" className="tecla"  onclick="numero('*')">*</button>
						<button type="submit" className="tecla"  onclick="numero('0')">0</button>
						<button type="submit" className="tecla"  onclick="numero('#')">#</button>
					</div>
					<div id="llamando"></div>
					<div className="acciones">
						<button
							type="submit"
							className="accion"
							onclick="accion()"
							value="espera"
							id="fun"
						>
							<svg
								xmlns="http://www.w3.org/2000/svg"
								width="25"
								height="16"
								fill="currentColor"
								className="bi bi-telephone-fill"
								viewBox="0 0 16 16"
							>
								<path
									// fill-rule="evenodd"
									d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z"
								/>
							</svg>
						</button>

					</div>
				</div>
			</div>
		</div>
	);
};


/* 

	Obtener los datos del telefono correspondiente y enviarlos al controlador

	Telefono: ID, El numero marcado
	


*/