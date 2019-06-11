within Granja_Solar.Componentes;

model Diodo
  extends Granja_Solar.Conectores.TwoPin(v(start=0));
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = 298.15);
  constant Modelica.SIunits.Charge Q = 1.6021766208E-19;
  parameter Real m = 1;
  parameter Modelica.SIunits.Resistance R = 1E8 ;
  parameter Modelica.SIunits.Temperature TRef = 298.15  annotation (
    Dialog(group = "Reference data"));
  parameter Modelica.SIunits.Voltage VRef(min = Modelica.Constants.small) = 0.6292 annotation (
    Dialog(group = "Reference data"));
  parameter Modelica.SIunits.Current IRef(min = Modelica.Constants.small) = 8.540 annotation (
    Dialog(group = "Reference data"));
  parameter Modelica.SIunits.LinearTemperatureCoefficient alphaI = +0.00053 annotation (
    Dialog(group = "Reference data"));
  parameter Modelica.SIunits.LinearTemperatureCoefficient alphaV = -0.00340  annotation (
    Dialog(group = "Reference data"));
  Modelica.SIunits.Voltage Vt;
  Modelica.SIunits.Voltage VRefActual;
  Modelica.SIunits.Current IRefActual ;
  Modelica.SIunits.Current Ids;
  parameter Modelica.SIunits.Voltage Bv = 5.1 ;
  parameter Modelica.SIunits.Current Ibv = 0.7;
  parameter Real Nbv = 0.74;
  parameter Integer ns = 1;
  parameter Integer nsModule(final min = 1) = 1 ;
  parameter Integer npModule(final min = 1) = 1 ;
  final parameter Modelica.SIunits.Voltage VtRef = Modelica.Constants.k * TRef / Q ;
  final parameter Modelica.SIunits.Voltage VBv = (-m * Nbv * log(IdsRef * Nbv / Ibv) * VtRef) - Bv ;
  final parameter Modelica.SIunits.Current IdsRef = IRef / (exp(VRef / m / VtRef) - 1);
  final parameter Modelica.SIunits.Voltage VNegLin = (-VRef / m / VtRef * (Nbv * m * VtRef)) - Bv ;
  Modelica.SIunits.Voltage VNeg;
  Modelica.SIunits.Voltage vCell = v / ns / nsModule ;
  Modelica.SIunits.Voltage vModule = v / nsModule ;
  Modelica.SIunits.Current iModule = i / npModule ;
equation
  Vt = Modelica.Constants.k * T_heatPort / Q;
  VRefActual = VRef * (1 + alphaV * (T_heatPort - TRef));
  IRefActual = IRef * (1 + alphaI * (T_heatPort - TRef));
  Ids = IRefActual / (exp(VRefActual / m / Vt) - 1);
  LossPower = v * i;
VNeg = m * Vt * log(Vt / VtRef);
  i / npModule = smooth(1, if v / ns / nsModule > VNeg then Ids * (exp(v / ns / nsModule / m / Vt) - 1) + v / ns / nsModule / R elseif v / ns / nsModule > VBv then Ids * v / ns / nsModule / m / VtRef + v / ns / nsModule / R
   elseif v / ns / nsModule > VNegLin then (-Ibv * exp(-(v / ns / nsModule + Bv) / (Nbv * m * Vt))) + Ids * VBv / m / VtRef + v / ns / nsModule / R else Ids * v / ns / nsModule / m / Vt - Ibv * exp(VRef / m / VtRef) * (1 - (v / ns / nsModule + Bv) / (Nbv * m * Vt) - VRef / m / VtRef) + v / ns / nsModule / R);
  annotation (
    defaultComponentName = "diode",
    Documentation(info="<html>
<p>This model consists of four different regions:<p>
<ul>
<li>Forward direction: exponential function, see <a href=\"modelica://PhotoVoltaics.Components.Diodes.Diode2exp\">Diode2exp</a></li>
<li>Backwards direction: linear, before reaching backwards breakthrough region<li>
<li>Breaktrough: exponential function, see <a href=\"modelica://PhotoVoltaics.Components.Diodes.Diode2exp\">Diode2exp</a></li>
<li>Beyond breakthrough: linear region in order to limit magnitude of exponential breakthrough</li>
</ul>

<p>One particular feature of this scalable model is that this diode can be used to model cells, symmetric modules and symmetric plants, 
as </p>
<ul>
<li>the number of series connections of a module,</li>
<li>the number of series connections of a plant,</li>
<li>the number of parallel connections of a plant</li>
</ul>
<p>can be considered.</p>

<p>The breakthrough parameters are basically taken from 
<a href=\"modelica://Modelica.Electrical.Analog.Semiconductors.ZDiode\">ZDiode</a>.
</p>

<p>The temperature dependence of the temperature voltage <code>Vt</code> and saturation current of the diode are 
considered consistently in the <a href=\"modelica://PhotoVoltaics.Interfaces.PartialDiode\">partial diodel</a> model.
</p></html>"),
  Icon(coordinateSystem(initialScale = 0.1), graphics={Line(visible = false, points = {{0, -101}, {0, -20}}, color = {127, 0, 0}, pattern = LinePattern.Dot), Polygon(origin = {36, -46}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, points = {{-8, 46}, {-68, 86}, {-68, 6}, {-8, 46}}), Line(origin = {36.8421, -46.6667}, points = {{-8, 86}, {-8, 6}}, color = {0, 0, 255}), Line(origin = {0, -46.0526}, points = {{-100, 46}, {100, 46}}, color = {0, 0, 255})}),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}})));
end Diodo;
