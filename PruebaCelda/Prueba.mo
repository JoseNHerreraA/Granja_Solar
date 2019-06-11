within Granja_Solar.PruebaCelda;

model Prueba
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.VariableResistor variableResistor annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {40, 0})));
  Modelica.Blocks.Sources.Ramp powerRamp(duration = 0.6, height = 8, offset = -4, startTime = 0.2) annotation (
    Placement(visible = true, transformation(origin = {70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Granja_Solar.Componentes.CeldaPV cell(Datos_Modelo=Datos1) annotation (Placement(visible=true, transformation(
        origin={0,0},
        extent={{-10,10},{10,-10}},
        rotation=-90)));
  parameter Granja_Solar.Componentes.Datos Datos1 annotation (
    Placement(visible = true, transformation(origin = {70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real ref = Datos1.VmpRef / Datos1.ImpRef;
equation
  powerRamp.y =ref*10^powerRamp.y;
  connect(powerRamp.y, variableResistor.R) annotation(
    Line(points = {{60, 0}, {52, 0}, {52, 0}, {52, 0}}, color = {0, 0, 127}));
  connect(ground.p, cell.pinNeg1) annotation(
    Line(points = {{0, -20}, {0, -20}, {0, -8}, {0, -8}}, color = {0, 0, 255}));
  connect(variableResistor.p, cell.pinPos1) annotation(
    Line(points = {{40, 10}, {40, 10}, {40, 24}, {0, 24}, {0, 8}, {0, 8}}, color = {0, 0, 255}));
  connect(ground.p, variableResistor.n) annotation(
    Line(points = {{0, -20}, {40, -20}, {40, -10}, {40, -10}}, color = {0, 0, 255}));
end Prueba;
