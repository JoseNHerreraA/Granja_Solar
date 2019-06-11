within Granja_Solar.Conectores;

partial model TwoPin
  Modelica.SIunits.Voltage v;
  Modelica.SIunits.Current i;
  PinPos pinPos1 annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PinNeg pinNeg1 annotation(
    Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  v = pinPos1.v - pinNeg1.v;
  0 = pinPos1.i + pinNeg1.i;
  i = pinPos1.i;
annotation(
    Icon(graphics = {Rectangle(origin = {0, -1}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, lineThickness = 0, extent = {{-80, 9}, {80, -9}})}, coordinateSystem(initialScale = 0.1)));
end TwoPin;
