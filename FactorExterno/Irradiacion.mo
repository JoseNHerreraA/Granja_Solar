within Granja_Solar.FactorExterno;

model Irradiacion
  import Modelica.Constants.pi;
  import Granja_Solar.FactorExterno.Funciones.Radianes;
  import Granja_Solar.FactorExterno.Funciones.Grados;
  import Granja_Solar.FactorExterno.Funciones.Dia;
  parameter Integer DiaInicio(final min = 1, final max = 31) = 4;
  parameter Integer MesInicio(final min = 1, final max = 12) = 8;
  parameter Integer InicioA = 2016;
  parameter Integer ZonaHoraria = 1;
  parameter Modelica.SIunits.Angle longitud = -75.4635917;
  parameter Modelica.SIunits.Angle latitud = 10.369055399999999;
  parameter Modelica.SIunits.Irradiance irradiacionRef = 1000;
  parameter Modelica.SIunits.Angle gamma = 10 * pi / 180;
  parameter Modelica.SIunits.Angle acimut = 0;
  Integer Dia_A_Inicio(start = Dia(DiaInicio, MesInicio, InicioA), fixed = true);
  Integer Dia_A(final start = Dia(DiaInicio, MesInicio, InicioA), fixed = true);
  Integer Dias_A(final start = Dia(31, 12, InicioA), fixed = true);
  Integer A(final start = InicioA, fixed = true);
  Modelica.SIunits.Angle Jprime(final start = Dia(DiaInicio, MesInicio, InicioA) / Dia(31, 12, InicioA) * 2 * pi, fixed = true);
  Real delta_J;
  Real timeequation_J;
  Modelica.SIunits.Conversions.NonSIunits.Time_day TiempoLocal_Dias "Local time in days";
  Integer localDias "Locale day";
  Modelica.SIunits.Time localTiempo "Local time";
  Modelica.SIunits.Conversions.NonSIunits.Time_hour localHoras "Local time in unit hours";
  Modelica.SIunits.Conversions.NonSIunits.Time_hour LocalHoraMedia "Local mean time in unit hours";
  Modelica.SIunits.Conversions.NonSIunits.Time_hour HoraMediaReal "True mean time in unit hours";
  Modelica.SIunits.Angle horasAngulo;
  Modelica.SIunits.Angle AlturaSol;
  Modelica.SIunits.Angle AcimutManana;
  Modelica.SIunits.Angle AcimutTarde;
  Modelica.SIunits.Angle AcimutSol;
  Modelica.SIunits.Angle AnguloIncidencia;
  Modelica.SIunits.Irradiance IrradiacionHorizontal;
  Modelica.SIunits.Irradiance IrradianceInclinada;
  Modelica.Blocks.Interfaces.RealOutput irradiacion annotation (
    Placement(transformation(extent={{100,-10},{120,10}})));
algorithm
  // Calculate ratio of day w.r.t. total number of days of a year as equivalent angle
  when sample(24 * 3600, 24 * 3600) then
    Dia_A := mod(pre(Dia_A), pre(Dias_A)) + 1;
  end when;
  when Dia_A_Inicio + localDias == Dias_A + 1 then
    Dia_A_Inicio := 1;
    A := pre(A) + 1;
    Dias_A := Dia(31, 12, A);
  end when;
  // One full year is reached
  // Reset start day of year
  // Increment year
  // Determined actual number of total days of year

equation
Jprime = Dia_A / Dias_A * 2 * pi;
  delta_J = Radianes(0.3948 - 23.2559 * cos(Jprime + Radianes(9.1)) - 0.3915 * cos(2 * Jprime + Radianes(5.4)) - 0.1764 * cos(3 * Jprime + Radianes(26)));
  timeequation_J = 0.0066 + 7.3525 * cos(Jprime + Radianes(85.9)) + 9.9359 * cos(2 * Jprime + Radianes(108.9)) + 0.3387 * cos(3 * Jprime + Radianes(105.2));
  // Zeit LZ = time
  localTiempo = time;
  // Convert time into unit hours
  localHoras = localTiempo / 3600;
  // Convert time into unit days
  TiempoLocal_Dias = localHoras / 24;
  // Convert time from real days into integer days (floor)
  localDias = integer(floor(TiempoLocal_Dias));
  // Calculate locale mean time
  LocalHoraMedia = localHoras - ZonaHoraria + 4 / 60 * longitud * 180 / Modelica.Constants.pi;
  // cos(latitude)*tan(...)
  HoraMediaReal = LocalHoraMedia + timeequation_J / 60;
  horasAngulo = Radianes((12 - HoraMediaReal) * 15);
  AlturaSol = Grados(asin(cos(horasAngulo) * cos(latitud) * cos(delta_J) + sin(latitud) * sin(delta_J))) * (Modelica.Constants.pi / 180);
  AcimutManana = Modelica.Constants.pi - acos((sin(AlturaSol) * sin(latitud) - sin(delta_J)) / (cos(AlturaSol) * cos(latitud)));
  AcimutTarde = Modelica.Constants.pi + acos((sin(AlturaSol) * sin(latitud) - sin(delta_J)) / (cos(AlturaSol) * cos(latitud)));
  AcimutSol = if mod(localHoras, 24) <= 12 then AcimutManana else AcimutTarde;
  AnguloIncidencia = acos((-cos(AlturaSol) * sin(gamma) * cos(AcimutSol - acimut)) + sin(AlturaSol) * cos(gamma));
  IrradiacionHorizontal = if AlturaSol < 0 then 0 else irradiacionRef * sin(AlturaSol);
  IrradianceInclinada = if AnguloIncidencia > pi / 2 then 0 else if abs(sin(AlturaSol)) < 1E-5 then 0 else IrradiacionHorizontal * (cos(AnguloIncidencia) / sin(AlturaSol));
  irradiacion = IrradianceInclinada;
 end Irradiacion;
