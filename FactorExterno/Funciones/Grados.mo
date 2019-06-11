within Granja_Solar.FactorExterno.Funciones;

function Grados
  input Real radianes;
  output Real grados;
algorithm
  grados:=radianes * 180 / Modelica.Constants.pi;
end Grados;
