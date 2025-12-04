/* -------------------------------------------------------
   Tibás – pendiente base (zoom de detalle)
   ------------------------------------------------------- */
#tibasslope[zoom>=11][zoom<=22] {
  raster-opacity: 0.95;
  raster-scaling: bilinear;
}

/* Cantón Tibás: borde + NOMBRE TIBÁS */
#geocantonestibas[zoom>=11][zoom<=18] {
  polygon-opacity: 0;
  line-color: #000000;
  line-width: 1.8;
}

/* Solo etiqueta el cantón TIBÁS */
#geocantonestibas[zoom>=11][zoom<=12][NCANTON="TIBAS"] {
  text-name: [NCANTON];           /* "TIBAS" */
  text-size: 14;
  text-fill: #000000;
  text-face-name: "DejaVu Sans Bold";
  text-halo-fill: #ffffff;
  text-halo-radius: 2.0;
  text-placement: point;
  text-min-distance: 5;
}


/* Distritos SOLO del cantón Tibás */
#geodistritostibas[zoom>=13][zoom<=15][NCANTON="TIBAS"] {
  polygon-opacity: 0;
  line-color: #666666;
  line-width: 0.7;
  line-dasharray: 2,2;

  text-name: [NDISTRITO];
  text-size: 10;
  text-fill: #222222;
  text-face-name: "DejaVu Sans Oblique";
  text-halo-fill: #ffffff;
  text-halo-radius: 1.0;
  text-placement: point;
  text-min-distance: 10;
}

/* ===================================================
   RÍOS DENTRO DE TIBÁS
   =================================================== */
#georiostibas[zoom>=15][zoom<=18] {
  line-color: #2b8cbe;
  line-width: 0.8;
  line-opacity: 0.95;

  text-name: [NOMBRE];
  text-placement: line;
  text-size: 9;
  text-fill: #084594;
  text-face-name: "DejaVu Sans Book";
  text-halo-fill: #ffffff;
  text-halo-radius: 1.0;
  text-min-distance: 40;
}

/* ===================================================
   CARRETERAS NACIONALES (shapefile del curso)
   =================================================== */

/* Todas las carreteras nacionales en Tibás */
#geocarretertibas[zoom>=15][zoom<=18] {
  line-color: #777777;
  line-width: 0.9;
  line-opacity: 0.95;

  text-name: [CODIGO];      /* N 5, N 102, etc. */
  text-placement: line;
  text-size: 9;
  text-fill: #222222;
  text-face-name: "DejaVu Sans Book";
  text-halo-fill: #ffffff;
  text-halo-radius: 1.0;
  text-min-distance: 40;
}

/* Nacionales dentro de Tibás más marcadas */
#geocarretertibas[zoom>=15][zoom<=18][TIPO="CARRETERA NACIONAL"] {
  line-color: #e41a1c;
  line-width: 1.3;
}

/* ===================================================
   CAPAS OSM: PARQUES, CALLES Y PUNTOS
   =================================================== */

/* ------------ PARQUES / ZONAS VERDES (polígonos) --- */
/* Capa: tibas_parques_osm */
#tibasparquesosm[zoom>=15] {
  polygon-fill: #8dd3c7;
  polygon-opacity: 0.5;

  line-color: #1b7837;
  line-width: 0.8;
  line-opacity: 0.9;
}

/* ------------ CALLES OSM (líneas) ------------------- */
/* Capa: tibas_calles_osm */

/* Base: todas las vías */
#tibascallesosm[zoom>=15] {
  line-color: #bbbbbb;
  line-width: 0.5;
  line-opacity: 0.7;
}

/* Primarias */
#tibascallesosm[zoom>=14][highway="primary"],
#tibascallesosm[zoom>=14][highway="trunk"] {
  line-color: #f16913;
  line-width: 1.6;
}

/* Secundarias y terciarias */
#tibascallesosm[zoom>=15][highway="secondary"],
#tibascallesosm[zoom>=15][highway="tertiary"] {
  line-color: #fd8d3c;
  line-width: 1.2;
}

/* Calles residenciales y unclassified */
#tibascallesosm[zoom>=16][highway="residential"],
#tibascallesosm[zoom>=16][highway="unclassified"] {
  line-color: #cccccc;
  line-width: 0.9;
}

/* Calles de servicio y estacionamientos */
#tibascallesosm[zoom>=16][highway="service"] {
  line-color: #dddddd;
  line-width: 0.7;
}

/* Vías peatonales / ciclovías / senderos */
#tibascallesosm[zoom>=16][highway="footway"],
#tibas_callesosm[zoom>=16][highway="path"],
#tibascallesosm[zoom>=16][highway="cycleway"],
#tibascallesosm[zoom>=16][highway="living_street"],
#tibascallesosm[zoom>=16][highway="pedestrian"] {
  line-color: #99cfff;
  line-width: 0.7;
  line-dasharray: 2,2;
}

/* ------------ PUNTOS OSM (POIs) --------------------- */
/* Capa: tibaspois  (puntos) */

/* Símbolo base para cualquier POI genérico */
#tibaspois[zoom>=15] {
  marker-width: 5;
  marker-fill: #555555;
  marker-line-color: #ffffff;
  marker-line-width: 0.5;
  marker-allow-overlap: false;   /* ayuda a que no se acumulen tanto */
}

/* ============================
   POBLADOS (place = town, etc.)
   ============================ */
#tibaspois[zoom>=15][place="town"],
#tibaspois[zoom>=15][place="village"],
#tibaspois[zoom>=15][place="hamlet"],
#tibaspois[zoom>=15][place="suburb"],
#tibaspois[zoom>=15][place="neighbourhood"] {
  marker-file: url("icons/poblado.png");
  marker-width: 20;
}

/* ============================
   EDUCACIÓN: escuelas / colegios / universidades
   ============================ */
#tibaspois[zoom>=15][amenity="school"],
#tibaspois[zoom>=15][amenity="kindergarten"],
#tibaspois[zoom>=15][amenity="college"],
#tibaspois[zoom>=15][amenity="university"] {
  marker-file: url("icons/school.png");   /* ícono de escuela */
  marker-width: 20;
}

/* ============================
   SALUD: hospitales
   ============================ */
#tibaspois[zoom>=15][amenity="hospital"] {
  marker-file: url("icons/hospital.png"); /* ícono con cruz roja, por ejemplo */
  marker-width: 20;
}

/* SALUD: clínicas / doctores / dentistas / farmacias */
#tibaspois[zoom>=15][amenity="clinic"],
#tibaspois[zoom>=15][amenity="doctors"],
#tibaspois[zoom>=15][amenity="dentist"],
#tibaspois[zoom>=15][amenity="pharmacy"] {
  marker-file: url("icons/clinic.png");   /* otro símbolo distinto al hospital */
  marker-width: 20;
}

/* ============================
   GASOLINERAS
   ============================ */
#tibaspois[zoom>=15][amenity="fuel"] {
  marker-file: url("icons/fuel.png");
  marker-width: 20;
}

/* ============================
   BANCOS Y CAJEROS
   ============================ */
#tibaspois[zoom>=15][amenity="bank"],
#tibaspois[zoom>=15][amenity="atm"] {
  marker-file: url("icons/bank.png");
  marker-width: 20;
}

/* ============================
   COMERCIOS EN GENERAL (cualquier shop)
   ============================ */
#tibaspois[zoom>=15][shop!=""] {
  marker-file: url("icons/shop.png");
  marker-width: 20;
}

/* Etiqueta con el nombre para TODOS los POIs con nombre */
/* (cumple el requisito de que todos tengan etiqueta, pero solo a buen zoom) */
#tibaspois[zoom>=17][name!=""] {
  text-name: [name];
  text-size: 9;
  text-fill: #000000;
  text-face-name: "DejaVu Sans Book";
  text-halo-fill: #ffffff;
  text-halo-radius: 1.2;
  text-dy: -16;
}

