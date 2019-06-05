within Granja_Solar.Componentes;

model Diodo
  extends Granja_Solar.Conectores.TwoPin(v(start=0));
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = 298.15);
  constant Modelica.SIunits.Charge Q = 1.6021766208E-19 "Elementary charge of electron";
  parameter Real m = 1 "Ideality factor of diode";
  parameter Modelica.SIunits.Resistance R = 1E8 "Parallel ohmic resistance";
  parameter Modelica.SIunits.Temperature TRef = 298.15 "Reference temperature" annotation (
    Dialog(group = "Reference data"));
  parameter Modelica.SIunits.Voltage VRef(min = Modelica.Constants.small) = 0.6292 "Reference voltage > 0 at TRef" annotation (
    Dialog(group = "Reference data"));
  parameter Modelica.SIunits.Current IRef(min = Modelica.Constants.small) = 8.540 "Reference current > 0 at TRef" annotation (
    Dialog(group = "Reference data"));
  parameter Modelica.SIunits.LinearTemperatureCoefficient alphaI = +0.00053 "Temperature coefficient of reference current at TRef" annotation (
    Dialog(group = "Reference data"));
  parameter Modelica.SIunits.LinearTemperatureCoefficient alphaV = -0.00340 "Temperature coefficient of reference voltage at TRef*" annotation (
    Dialog(group = "Reference data"));
  Modelica.SIunits.Voltage Vt "Voltage equivalent of temperature (k*T/Q)";
  Modelica.SIunits.Voltage VRefActual "Reference voltage w.r.t. actual temperature";
  Modelica.SIunits.Current IRefActual "Reference current w.r.t. actual temperature";
  Modelica.SIunits.Current Ids "Saturation current";
  
  
  parameter Modelica.SIunits.Voltage Bv = 5.1 "Breakthrough voltage";
  parameter Modelica.SIunits.Current Ibv = 0.7 "Breakthrough knee current";
  parameter Real Nbv = 0.74 "Breakthrough emission coefficient";
  parameter Integer ns = 1 "Number of series connected cells per module";
  parameter Integer nsModule(final min = 1) = 1 "Number of series connected modules";
  parameter Integer npModule(final min = 1) = 1 "Number of parallel connected modules";
  final parameter Modelica.SIunits.Voltage VtRef = Modelica.Constants.k * TRef / Q "Reference voltage equivalent of temperature";
  final parameter Modelica.SIunits.Voltage VBv = (-m * Nbv * log(IdsRef * Nbv / Ibv) * VtRef) - Bv "Voltage limit of approximation of breakthrough";
  final parameter Modelica.SIunits.Current IdsRef = IRef / (exp(VRef / m / VtRef) - 1) "Reference saturation current";
  final parameter Modelica.SIunits.Voltage VNegLin = (-VRef / m / VtRef * (Nbv * m * VtRef)) - Bv "Limit of linear range left of breakthrough";
  Modelica.SIunits.Voltage VNeg "Limit of linear negative voltage range";
  Modelica.SIunits.Voltage vCell = v / ns / nsModule "Cell voltage";
  Modelica.SIunits.Voltage vModule = v / nsModule "Module voltage";
  Modelica.SIunits.Current iModule = i / npModule "Module current";
equation
// Temperature dependent voltage
  Vt = Modelica.Constants.k * T_heatPort / Q;
  // Re-calculate reference voltage and current with respect to reference temperature
  VRefActual = VRef * (1 + alphaV * (T_heatPort - TRef));
  IRefActual = IRef * (1 + alphaI * (T_heatPort - TRef));
  // Actual temperature dependent saturation current is determined from reference voltage and current
  Ids = IRefActual / (exp(VRefActual / m / Vt) - 1);
  LossPower = v * i;
VNeg = m * Vt * log(Vt / VtRef);
  // Current approximation
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
