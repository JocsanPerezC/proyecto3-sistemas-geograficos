# Datos y Métodos – Proyecto 3 (Tibás)

## 0. Cantón de estudio
Este proyecto se desarrolló para el cantón de **Tibás**, en la provincia de San José, Costa Rica.

Todo el procesamiento se trabajó en el sistema de referencia geográfica:

- **WGS84 – EPSG:4326**

Esto garantiza compatibilidad entre los datos del repositorio del curso y los datos provenientes de OpenStreetMap (OSM).

---

## 1. Datos utilizados

### 1.1 Capas base del repositorio del curso
Estas capas fueron utilizadas como insumo inicial para generar los recortes del cantón Tibás:

- `DEM.tif` — Modelo Digital de Elevación  
- `geoprovincias.shp`  
- `geocantones.shp`  
- `geodistritos.shp`  
- `georios.shp`  
- `geocarreter.shp`  
- `tibas_canton.shp` – polígono del cantón  

### 1.2 Capas derivadas para Tibás
A partir de las capas nacionales se generaron recortes específicos del cantón:

- `tibasslope.tif`  
- `geoprovinciastibas.shp`  
- `geocantonestibas.shp`  
- `geodistritostibas.shp`  
- `georiostibas.shp`  
- `geocarretertibas.shp`  

### 1.3 Capas OSM obtenidas mediante Overpass Turbo
Se descargaron datos actuales de OpenStreetMap:

- `tibas_pois.shp` – POIs (amenity, shop, tourism)  
- `tibas_calles_osm.shp` – red vial OSM  
- `tibas_parques_osm.shp` – parques y áreas verdes  

Todas fueron exportadas de GeoJSON a Shapefile usando GDAL.

---

## 2. Software utilizado
- **GDAL** – recortes raster/vectoriales y conversiones  
- **Overpass Turbo** – descarga OSM  
- **TileMill** – diseño y exportación del mapa (MBTiles)

---

## 3. Procesamiento del relieve y generación de pendiente

### 3.1 Cálculo de la pendiente nacional
```bash
gdaldem slope ^
  DEM.tif ^
  slope_dem.tif ^
  -s 1.0 -compute_edges -of GTiff
```

### 3.2 Recorte de pendiente a Costa Rica
```bash
gdalwarp ^
  -cutline geocantones.shp ^
  -crop_to_cutline -dstnodata -9999 ^
  slope_dem.tif ^
  crslope.tif
```

### 3.3 Recorte final para Tibás
```bash
gdalwarp ^
  -cutline tibas_canton.shp ^
  -crop_to_cutline -dstnodata -9999 ^
  crslope.tif ^
  tibasslope.tif
```

---

## 4. Recortes vectoriales del cantón Tibás

### 4.1 Provincias
```bash
ogr2ogr -clipsrc tibas_canton.shp geoprovinciastibas.shp geoprovincias.shp
```

### 4.2 Cantones
```bash
ogr2ogr -clipsrc tibas_canton.shp geocantonestibas.shp geocantones.shp
```

### 4.3 Distritos
```bash
ogr2ogr -clipsrc tibas_canton.shp geodistritostibas.shp geodistritos.shp
```

### 4.4 Ríos
```bash
ogr2ogr -clipsrc tibas_canton.shp georiostibas.shp georios.shp
```

### 4.5 Carreteras nacionales
```bash
ogr2ogr -clipsrc tibas_canton.shp geocarretertibas.shp geocarreter.shp
```

---

## 5. Descarga y preparación de datos OSM (Overpass Turbo)

### 5.1 Área de consulta
```txt
[out:json][timeout:60];
{{geocodeArea:"Tibas, San José, Costa Rica"}}->.searchArea;
```

### 5.2 Calles OSM
Consulta:
```txt
way["highway"](area.searchArea);
out geom;
```
Conversión:
```bash
ogr2ogr -f "ESRI Shapefile" tibas_calles_osm.shp tibas_calles_osm.geojson -nlt LINESTRING
```

### 5.3 Parques y zonas verdes
Consulta:
```txt
nwr["leisure"](area.searchArea);
out geom;
```
Conversión:
```bash
ogr2ogr -f "ESRI Shapefile" tibas_parques_osm.shp tibas_parques_osm.geojson -nlt POLYGON
```

### 5.4 Puntos de Interés (POIs)
Consulta:
```txt
(
  node["amenity"](area.searchArea);
  node["shop"](area.searchArea);
  node["tourism"](area.searchArea);
);
out;
```

Conversión:
```bash
ogr2ogr -f "ESRI Shapefile" tibas_pois.shp tibas_pois.geojson -nlt POINT
```

---

## 6. Integración en TileMill

Capas cargadas:
- Pendiente: `tibasslope`  
- Límite cantonal: `geocantonestibas`  
- Distritos: `geodistritostibas`  
- Ríos: `georiostibas`  
- Carreteras nacionales: `geocarretertibas`  
- Calles OSM: `tibas_calles_osm`  
- Parques OSM: `tibas_parques_osm`  
- POIs: `tibas_pois`  

### 6.1 Ajustes realizados
- Renombrar capas OSM para evitar errores  
- Revisar atributos (`highway`, `amenity`, `shop`, `name`)  
- Ajustar niveles de zoom  
- Aplicar simbología diferenciada:
  - Carreteras: rojo  
  - Calles OSM: por tipo  
  - Parques: verde semitransparente  
  - POIs: colores variados  

---

## 7. Publicación del mapa final
- Exportación **MBTiles** desde TileMill  
- Publicación en **Vercel**  
- Creación de `index.html` para visualización web  

---

## 8. Resultado final
El mapa final integra:

- Datos oficiales y datos OSM actualizados  
- Recortes precisos del cantón  
- Simbología profesional  
- Mosaico raster de pendiente  
- Capas temáticas claras (carreteras, ríos, parques, POIs)

Es un mapa mosaico completo, claro, funcional y listo para publicación web.
