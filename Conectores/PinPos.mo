within Granja_Solar.Conectores;

connector PinPos
  Modelica.SIunits.ElectricPotential v;
  flow Modelica.SIunits.Current i;
  annotation(
    Icon(graphics = {Ellipse(fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{40, -40}, {-40, 40}}, endAngle = 360)}),
    Diagram(graphics = {Ellipse(origin = {1, -1}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-39, 39}, {39, -39}}, endAngle = 360)}));
end PinPos;
