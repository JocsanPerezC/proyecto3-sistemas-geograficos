# Proyecto 3 – Mapa en Mosaico del Cantón de Tibás  
**Curso:** IC8017 – Sistemas de Información Geográfica  
**Instituto Tecnológico de Costa Rica**

- **Jocsan Pérez Coto, 2022437948**  
- **Valeska Brenes, 2021031484**

## Enlace de publicación del mapa  
Nuestro mapa final está publicado en:  
**[https://proyecto3-sistemas-geograficos.vercel.app](https://proyecto3-sistemas-geograficos.vercel.app)**  


## 0. Cantón de estudio
Este proyecto se desarrolló para el cantón de **Tibás**, en la provincia de San José, Costa Rica.

Todo el procesamiento se trabajó en el sistema de referencia geográfica:

- **WGS84 – EPSG:4326**

Trabajamos con esta referencia para que hubiera compatibilidad entre los datos del curso y los datos provenientes de OpenStreetMap (OSM).

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

- `tibas_pois.shp` – POIs (amenity, shop, gas)  
- `tibas_calles_osm.shp` – red vial OSM  
- `tibas_parques_osm.shp` – parques y áreas verdes  

Todas fueron exportadas de GeoJSON a Shapefile usando GDAL.

---

## 2. Software utilizado
- **GDAL** – recortes raster/vectoriales y conversiones  
- **Overpass Turbo** – descarga OSM  
- **TileMill** – diseño y exportación del mapa (MBTiles)

Todos los comandos se realizaron desde el CMD de windows y utilizando el programa de gdal con la dirección de la carpeta de bin, por ejemplo: ```C:\Users\Admin\Downloads\gdal\bin```.

---

## 3. Procesamiento del relieve y generación de pendiente

Generamos la capa de pendiente que usamos como imagen base del mapa.

### 3.1 Cálculo de la pendiente nacional
``` 
gdaldem slope DEM.tif slope_dem.tif -s 1.0 -compute_edges -of GTiff
 ```

### 3.2 Recorte de pendiente a Costa Rica
```
gdalwarp -cutline geocantones.shp -crop_to_cutline -dstnodata -9999 slope_dem.tif crslope.tif
```

### 3.3 Recorte final para Tibás
```
gdalwarp -cutline tibas_canton.shp -crop_to_cutline -dstnodata -9999 crslope.tif tibasslope.tif
```

---

## 4. Recortes vectoriales del cantón Tibás


### 4.1 Provincias
```
ogr2ogr -clipsrc tibas_canton.shp geoprovinciastibas.shp geoprovincias.shp
```

### 4.2 Cantones
```
ogr2ogr -clipsrc tibas_canton.shp geocantonestibas.shp geocantones.shp
```

### 4.3 Distritos
```
ogr2ogr -clipsrc tibas_canton.shp geodistritostibas.shp geodistritos.shp
```

### 4.4 Ríos
```
ogr2ogr -clipsrc tibas_canton.shp georiostibas.shp georios.shp
```

### 4.5 Carreteras nacionales
```
ogr2ogr -clipsrc tibas_canton.shp geocarretertibas.shp geocarreter.shp
```

De esta manera obtuvimos todos los shp necesarios para utilizarlos en TileMill.

---

## 5. Descarga y preparación de datos OSM (Overpass Turbo)

### 5.1 Área de consulta

Todas las consultas se hicieron juntas y se descargaron desde Overpass Turbo.
Luego se hizo la conversión para poder utilizarlas.

Zona de Tibas:
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
```
ogr2ogr -f "ESRI Shapefile" tibas_calles_osm.shp tibas_calles_osm.geojson -nlt LINESTRING
```

### 5.3 Parques y zonas verdes
Consulta:
```txt
nwr["leisure"](area.searchArea);
out geom;
```
Conversión:
```
ogr2ogr -f "ESRI Shapefile" tibas_parques_osm.shp tibas_parques_osm.geojson -nlt POLYGON
```

### 5.4 Puntos de Interés (POIs)
Consulta:
```txt
(
  node["amenity"](area.searchArea);
  node["shop"](area.searchArea);
  node["gas"](area.searchArea);
  ...
);
out;
```

Conversión:
```
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
Para realizar esta parte, en la aplicación de TileMill se exporto el proyecto como un archivo .mbtiles. Una vez con el archivo se tuvo que utilizar el siguiente comando para poder descomprimir el archivo con todas las carpetas de los zooms con sus respectivas imágenes:
```
python mb-util.py proyecto3.mbtiles tiles --image_format=png
```

- Publicación en **Vercel**  
Esto se realiza muy fácilmente, unicamente subimos el repositorio a la pagina de vercel y ya el se compila y ejecuta automáticamente.

- Creación de `index.html` para visualización web  

---

## 8. Resultado final
El mapa final integra:

- Datos oficiales y datos OSM actualizados  
- Recortes precisos del cantón  
- Índice con simbología  
- Mosaico raster de pendiente  
- Capas temáticas claras (carreteras, ríos, parques, POIs)

Es un mapa mosaico completo, claro y funcional.
