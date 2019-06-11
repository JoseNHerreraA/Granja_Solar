within Granja_Solar.Componentes;

record Datos
  extends Modelica.Icons.Record;
  parameter String moduleName = "Generic";
  parameter Modelica.SIunits.Temperature TRef = 298.15 annotation (
    Dialog(group = "Reference data"));
  parameter Modelica.SIunits.Irradiance irradianceRef = 1000  annotation (
    Dialog(group = "Reference data"));
  parameter Modelica.SIunits.Voltage VocRef(min = Modelica.Constants.small) = 30.2  annotation (
    Dialog(group = "Reference data"));
  final parameter Modelica.SIunits.Voltage VocCellRef = VocRef / ns;
  parameter Modelica.SIunits.Current IscRef(min = Modelica.Constants.small) = 8.54 annotation (
    Dialog(group = "Reference data"));
  parameter Modelica.SIunits.Voltage VmpRef(min = Modelica.Constants.small) = 24.0 annotation(
    Dialog(group = "Reference data"));
  final parameter Modelica.SIunits.Voltage VmpCellRef = VmpRef / ns ;
  parameter Modelica.SIunits.Current ImpRef(min = Modelica.Constants.small) = 7.71  annotation (
    Dialog(group = "Reference data"));
  parameter Modelica.SIunits.LinearTemperatureCoefficient alphaIsc = +0.00053 annotation (
    Dialog(group = "Reference data"));
  parameter Modelica.SIunits.LinearTemperatureCoefficient alphaVoc = -0.00340 annotation (
    Dialog(group = "Reference data"));
  parameter Integer ns = 1 ;
  parameter Integer nb = 1 ;
  parameter Modelica.SIunits.Voltage BvCell = 18  annotation (
    Dialog(group = "Breakthrough data"));
  parameter Modelica.SIunits.Current Ibv = 1  annotation (
    Dialog(group = "Breakthrough data"));
  parameter Real Nbv = 0.74 annotation (
    Dialog(group = "Breakthrough data"));
  final parameter Modelica.SIunits.Voltage VtCellRef = Modelica.Constants.k * TRef / Q;
  constant Modelica.SIunits.Charge Q = 1.6021766208E-19 ;
  annotation (
    defaultComponentName = "",
    defaultComponentPrefixes = "parameter",
    Icon(coordinateSystem(preserveAspectRatio = false), graphics={  Text(lineColor = {0, 0, 255}, extent = {{-200, -150}, {200, -110}}, textString = "")}),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    Documentation(info="<html>
<p>This record defines parameters provided by photovoltaic module manufacturers.</p>
</html>"));
end Datos;
