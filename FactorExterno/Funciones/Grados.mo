within Granja_Solar.FactorExterno.Funciones;

function Grados
  input Real radianes "Angle in rad";
  output Real grados "Angle in degree";
algorithm
  grados:=radianes * 180 / Modelica.Constants.pi;
end Grados;
