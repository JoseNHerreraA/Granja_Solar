within Granja_Solar.Componentes;

model Diodo
  Granja_Solar.Conectores.TwoPin twoPin1 annotation(
    Placement(visible = true, transformation(origin = {-1, -1}, extent = {{-101, -101}, {101, 101}}, rotation = 0), iconTransformation(origin = {-1, 1}, extent = {{-97, -97}, {97, 97}}, rotation = 0)));
  parameter Modelica.SIunits.Resistance Ron(final min = 0) = 1e-5;
  parameter Modelica.SIunits.Conductance Goff(final min = 0) = 1e-5;
  parameter Modelica.SIunits.Voltage Vknee(final min = 0) = 0;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort;
  Boolean off(start = true);
protected
  Real s(start = 0, final unit = "1") "Auxiliary variable for actual position on the ideal diode characteristic";
  /* s = 0: knee point
       s < 0: below knee point, blocking
       s > 0: above knee point, conducting */
  constant Modelica.SIunits.Voltage unitVoltage = 1 annotation(
    HideResult = true);
  constant Modelica.SIunits.Current unitCurrent = 1 annotation(
    HideResult = true);

equation
  twoPin1.v = s * unitCurrent * (if off then 1 else Ron) + Vknee;
  twoPin1.i = s * unitVoltage * (if off then Goff else 1) + Goff * Vknee;
  LossPower = twoPin1.v * twoPin1.i;
annotation(
    Diagram(graphics = {Rectangle(extent = {{-62, 40}, {-62, 40}}), Rectangle(extent = {{-76, 34}, {-76, 34}})}),
    Icon(graphics = {Polygon(lineColor = {0, 0, 255}, points = {{-60, 40}, {60, 0}, {-60, -40}, {-60, -38}, {-60, 40}, {-60, 40}, {-60, 40}}), Line(origin = {60, 0.5}, points = {{0, 39.5}, {0, -40.5}, {0, -40.5}, {0, -40.5}, {0, 31.5}, {0, -10.5}, {0, -24.5}}, color = {0, 0, 255}), Line(points = {{-80, 0}, {80, 0}, {80, 0}}, color = {0, 0, 255})}));end Diodo;
