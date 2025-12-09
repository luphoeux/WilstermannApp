# Guía para llenar los datos de Wilstermann

## 📋 Archivos CSV creados:

### 1. **partidos_futuros.csv** - Partidos por jugar
Columnas:
- `fecha`: Formato YYYY-MM-DD (ejemplo: 2025-12-15)
- `hora`: Formato HH:MM (ejemplo: 16:00)
- `equipo_local`: Nombre del equipo local
- `equipo_visitante`: Nombre del equipo visitante
- `estadio`: Nombre del estadio
- `competicion`: Liga Profesional, Copa Simón Bolívar, etc.
- `ciudad`: Ciudad donde se juega

### 2. **partidos_pasados.csv** - Partidos ya jugados
Columnas:
- `fecha`: Formato YYYY-MM-DD
- `hora`: Formato HH:MM
- `equipo_local`: Nombre del equipo local
- `equipo_visitante`: Nombre del equipo visitante
- `goles_local`: Goles del equipo local (número)
- `goles_visitante`: Goles del equipo visitante (número)
- `estadio`: Nombre del estadio
- `competicion`: Liga Profesional, Copa Simón Bolívar, etc.
- `ciudad`: Ciudad donde se jugó

### 3. **tabla_posiciones.csv** - Tabla de posiciones
Columnas:
- `posicion`: Posición en la tabla (1, 2, 3, etc.)
- `equipo`: Nombre del equipo
- `pj`: Partidos jugados
- `pg`: Partidos ganados
- `pe`: Partidos empatados
- `pp`: Partidos perdidos
- `gf`: Goles a favor
- `gc`: Goles en contra
- `dg`: Diferencia de goles (gf - gc)
- `pts`: Puntos totales

## 📝 Instrucciones:

1. Abre los archivos CSV con Excel o Google Sheets
2. Edita los datos según necesites
3. Puedes agregar o eliminar filas (la app se ajustará automáticamente)
4. **NO cambies los nombres de las columnas** (primera fila)
5. Guarda como CSV (separado por comas)

## ⚠️ Importante:

- Si una fila está vacía, no se mostrará
- Si llenas 10 filas, se mostrarán 10 tarjetas
- Los archivos están en: `assets/data/`
- Después de editar, necesitarás reiniciar la app para ver los cambios

## 🔄 Para convertir a Excel:

Si prefieres trabajar con un archivo .xlsx:
1. Abre Excel
2. Importa los 3 archivos CSV como hojas separadas
3. Guarda como .xlsx
4. Cuando termines, exporta cada hoja como CSV nuevamente
