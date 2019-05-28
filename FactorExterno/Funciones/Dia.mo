within Granja_Solar.FactorExterno.Funciones;

function Dia
  input Integer dia;
  input Integer mes;
  input Integer year;
  output Integer Dia;
protected
  Boolean bisiesto;
algorithm
  bisiesto := if mod(year, 4) > 0 then true else false;
  Dia := dia;
  Dia := Dia + (if mes > 1 then 31 else 0);
  Dia := Dia + (if mes > 2 then 28 + (if bisiesto then 1 else 0) else 0);
  Dia := Dia + (if mes > 3 then 31 else 0);
  Dia := Dia + (if mes > 4 then 30 else 0);
  Dia := Dia + (if mes > 5 then 31 else 0);
  Dia := Dia + (if mes > 6 then 30 else 0);
  Dia := Dia + (if mes > 7 then 31 else 0);
  Dia := Dia + (if mes > 8 then 31 else 0);
  Dia := Dia + (if mes > 9 then 30 else 0);
  Dia := Dia + (if mes > 10 then 31 else 0);
  Dia := Dia + (if mes > 11 then 30 else 0);
end Dia;
