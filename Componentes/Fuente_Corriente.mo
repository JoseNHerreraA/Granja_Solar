within Granja_Solar.Componentes;

model Fuente_Corriente
  extends Granja_Solar.Conectores.TwoPin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = 298.15);
  parameter Modelica.SIunits.Temperature TRef = 298.15;
  parameter Modelica.SIunits.Current IRef = 1;
  parameter Modelica.SIunits.Irradiance irradianceRef = 1000;
  parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef = 0;
  Modelica.Blocks.Interfaces.RealInput irradiance(unit = "W/m2") annotation (
    Placement(transformation(origin = {0, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
equation
  i=IRef*(irradiance/irradianceRef+ alphaRef*(T_heatPort - TRef));
  LossPower=0;
annotation(
    Icon(graphics = {Ellipse(extent = {{40, -40}, {-40, 40}}, endAngle = 360), Line(origin = {-61, 0}, points = {{-21, 0}, {21, 0}}), Line(origin = {60.9123, -0.438596}, points = {{-21, 0}, {21, 0}}), Rectangle(origin = {-7, 0}, fillColor = {255, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-19, 6}, {19, -6}}), Polygon(origin = {22, 0}, fillColor = {255, 255, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-12, 20}, {-12, -20}, {12, 0}, {12, 0}, {-12, 20}})}, coordinateSystem(initialScale = 0.1)));
end Fuente_Corriente;
