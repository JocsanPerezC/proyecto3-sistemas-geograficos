/* -------------------------------------------------------
   Tibás – pendiente base (zoom de detalle)
   ------------------------------------------------------- */
#tibasslope[zoom>=11][zoom<=18] {
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

/* ------------ PUNTOS OSM (POIs) --------------------- */
/* Capa: tibaspois  (puntos) */



/* ============================
   COMERCIOS EN GENERAL (cualquier shop)
   ============================ */
#tibaspois[zoom>=15][shop!=""] {
  marker-file: url("icons/school.png");
  marker-width: 9;
}

/* Etiqueta con el nombre para TODOS los POIs con nombre */
#tibaspois[zoom>=17][name!=""] {
  text-name: [name];
  text-size: 9;
  text-fill: #000000;
  text-face-name: "DejaVu Sans Book";
  text-halo-fill: #ffffff;
  text-halo-radius: 1.2;
  text-dy: -8;
}

