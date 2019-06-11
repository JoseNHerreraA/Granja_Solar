within Granja_Solar.Componentes;

model CeldaPV
  extends Granja_Solar.Conectores.TwoPin;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialConditionalHeatPort(T = 298.15);
  parameter Boolean IrradiacionConstante = true  annotation (
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true));
  parameter Modelica.SIunits.Irradiance Irradiacion = 1000  annotation (
    Dialog(enable = useConstantIrradiance));
  parameter Granja_Solar.Componentes.Datos Datos_Modelo annotation (
    choicesAllMatching = true,
    Placement(transformation(extent = {{60, 60}, {80, 80}})));
  Modelica.SIunits.Current iGenerada = -i;
  Modelica.SIunits.Power Potencia = v * i;
  Modelica.SIunits.Power PotenciaGenerada = v * iGenerada;
  Modelica.Blocks.Interfaces.RealInput IrradiacionVariable(unit = "W/m2") if not IrradiacionConstante annotation (
    Placement(visible = true,transformation( origin = {0, 120},extent = {{20, -20}, {-20, 20}}, rotation = 90), iconTransformation( origin = {0, 80},extent = {{20, -20}, {-20, 20}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant constante(final k = Irradiacion) if IrradiacionConstante annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-30, 80})));
  Diodo diodo1 annotation(
    Placement(visible = true, transformation(origin = {2, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  Modelica.Blocks.Interfaces.RealInput irradiacion(unit = "W/m2") annotation (
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {0, 70})));
  Granja_Solar.Componentes.Diodo diode(
    final useHeatPort = useHeatPort, 
    final T = T, 
    final TRef = Datos_Modelo.TRef,
    final Bv=Datos_Modelo.BvCell,
    final Ibv=Datos_Modelo.Ibv,
    final Nbv=Datos_Modelo.Nbv,
    final VRef=Datos_Modelo.VocCellRef,
    final IRef=Datos_Modelo.IscRef,
    final alphaI=Datos_Modelo.alphaIsc,
    final alphaV=Datos_Modelo.alphaVoc,
    final R=1E8,
    final m=m,
    final ns=1,
    final nsModule=1,
    final npModule=1);
  Granja_Solar.Componentes.Fuente_Corriente fuente_Corriente1(
    final useHeatPort = useHeatPort, 
    final T = T, 
    final TRef = Datos_Modelo.TRef,
    final irradianceRef=Datos_Modelo.irradianceRef,
    final alphaRef=Datos_Modelo.alphaIsc,
    final IRef=IphRef) annotation(
    Placement(visible = true, transformation(origin = {1, -1}, extent = {{-21, -21}, {21, 21}}, rotation = 180)));
final parameter Real m(start = 2, fixed = false);
final parameter Modelica.SIunits.Current IsdRef(start = 1E-4, fixed = false);
final parameter Modelica.SIunits.Current IphRef = Datos_Modelo.IscRef;
equation
  connect(fuente_Corriente1.irradiance, irradiacion) annotation(
    Line(points = {{2, -16}, {90, -16}, {90, 44}, {0, 44}, {0, 70}, {0, 70}}, color = {0, 0, 127}));
  connect(diodo1.pinPos1, fuente_Corriente1.pinNeg1) annotation(
    Line(points = {{-6, -34}, {-16, -34}, {-16, 0}, {-16, 0}}));
  connect(diodo1.pinNeg1, fuente_Corriente1.pinPos1) annotation(
    Line(points = {{10, -34}, {18, -34}, {18, 0}, {18, 0}}));
  connect(fuente_Corriente1.pinPos1, pinNeg1) annotation(
    Line(points = {{18, 0}, {80, 0}, {80, 0}, {80, 0}}));
  connect(pinPos1, fuente_Corriente1.pinNeg1) annotation(
    Line(points = {{-80, 0}, {-16, 0}, {-16, 0}, {-16, 0}}));
  connect(fuente_Corriente1.heatPort, internalHeatPort) annotation(
    Line(points = {{2, 20}, {-100, 20}, {-100, -80}, {-100, -80}}, color = {191, 0, 0}));
  connect(internalHeatPort, diodo1.heatPort) annotation(
    Line(points = {{-100, -80}, {-99, -80}, {-99, -44}, {2, -44}}, color = {191, 0, 0}));
  connect(irradiacion, IrradiacionVariable) annotation (
    Line(points = {{0, 70}, {0, 70}, {0, 120}}, color = {0, 0, 127}));
  connect(constante.y, irradiacion) annotation (
    Line(points = {{-19, 80}, {-20, 80}, {-20, 80}, {0, 80}, {0, 80}, {0, 70}, {0, 70}}, color = {0, 0, 127}));
  IphRef = IsdRef * (exp(Datos_Modelo.VocCellRef / m / Datos_Modelo.VtCellRef) - 1);
  IphRef = IsdRef * (exp(Datos_Modelo.VmpCellRef / m / Datos_Modelo.VtCellRef) - 1) + Datos_Modelo.ImpRef;
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 85, 127}, fillColor = {0, 85, 127}, fillPattern = FillPattern.Sphere, extent = {{-76, 60}, {76, -60}})}),
    Documentation(info="<html>
<p>This partial model contains the connectors and some parameters of photovoltaic components. Interfaces voltages,
currents and power terms are defined.</p>
</html>"));
end CeldaPV;
