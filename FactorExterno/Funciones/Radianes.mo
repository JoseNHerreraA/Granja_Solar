within Granja_Solar.FactorExterno.Funciones;

function Radianes
  input Real grados;
  output Real radianes;
algorithm
  radianes := grados * Modelica.Constants.pi / 180;
end Radianes;
