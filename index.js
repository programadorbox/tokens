const jwt = require('jsonwebtoken');


// Clave secreta (reemplaza con una clave segura)
const secret = 'tu_clave_secreta_segura';

// Datos a incluir en el token (payload)
const payload = {
  name: 'Pedro Perez',
  iss: "localhost@jwr.com", // Emisor del token
  sub: 'pedroperez@test.com', // Sujeto del token
  exp: Math.floor(Date.now() / 1000) + (60 * 60 * 24 * 2), // Expiración en 2 días
  iat: Math.floor(Date.now() / 1000), // Tiempo de emisión
  nbf: Math.floor(Date.now() / 1000) - (60 * 5) // No válido antes de 5 minutos
};

// Opciones para la generación del token
const options = {
  algorithm: 'HS256' // algoritmo 
};

// Generar el token
const token = jwt.sign(payload, secret, options);

console.log('Token generado:', token);

// Decodificar el token y verificar la firma
try {
  const decoded = jwt.verify(token, secret);
  console.log('Token decodificado:', decoded);
} catch (error) {
  console.error('Error al verificar el token:', error);
}