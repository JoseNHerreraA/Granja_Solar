within Granja_Solar.Conectores;

connector PinNeg
  Modelica.SIunits.ElectricPotential v;
  flow Modelica.SIunits.Current i;
  annotation(
    Icon(graphics = {Ellipse(origin = {-1, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{41, -40}, {-41, 40}}, endAngle = 360)}),
    Diagram(graphics = {Ellipse(fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-48, 40}, {48, -40}}, endAngle = 360)}));
end PinNeg;
