# ASIC Detección de Fallas Eléctricas

Proyecto ASIC desarrollado mediante un flujo completo RTL → GDSII utilizando herramientas open source para diseño digital VLSI.

El proyecto implementa un sistema de detección de fallas eléctricas descrito en Verilog/SystemVerilog y procesado mediante síntesis lógica, análisis de timing, colocación, ruteo y generación de layout físico.

Proyecto realizado en el TECNOLOGICO NACIONAL DE MEXICO, INSTITUTO TECNOLOGICO DE TUXTLA GUTIERREZ.
---

# Herramientas utilizadas

- Icarus Verilog — Simulación RTL
- GTKWave — Visualización de señales
- OpenLane — Flujo RTL → GDSII
- OpenROAD — Place & Route
- Yosys — Síntesis lógica
- klayout — Visualización de layout

# Flujo de Diseño ASIC

1. Diseño RTL en Verilog/SystemVerilog
2. Simulación funcional
3. Generación de waveform
4. Síntesis lógica
5. Floorplanning
6. Placement
7. Clock Tree Synthesis (CTS)
8. Routing
9. Static Timing Analysis (STA)
10. Power Analysis
11. Verificación DRC/LVS
12. Generación final GDSII

---

# Estructura del Proyecto


ASIC_DETECCION_FALLAS/
│
├── rtl/                 # Módulos RTL en Verilog/SystemVerilog
├── tb/                  # Testbench de simulación
├── sim/                 # Archivos de simulación y waveforms
├── synthesis/           # Reportes de síntesis
├── floorplan/           # Resultados de floorplanning
├── placement/           # Resultados de placement
├── cts/                 # Reportes Clock Tree Synthesis
├── routing/             # Resultados de routing
├── sta/                 # Reportes timing analysis
├── power/               # Reportes de potencia
├── gdsii/               # Layout final y archivos GDSII
├── docs/                # Documentación e imágenes
├── scripts/             # Scripts TCL y automatización
└── README.md
```

---

# Simulación

La simulación funcional fue realizada utilizando Icarus Verilog y GTKWave.

## Compilación

```bash
iverilog -g2012 -o sim_out tb/tb_top.sv rtl/*.sv


## ejecucion del scrip de para simulacion
DESDE LA RAIZ DEL PROYECTO

1.- dar permisos
chmod +x scripts/run_sim.sh

2.- ejecutar el script

./scripts/run_sim.sh

## Ejecución

```bash
vvp sim_out
```

## Visualización de señales

```bash
gtkwave waveform.vcd
```

---

# Flujo OpenLane

El diseño físico fue generado utilizando OpenLane/OpenROAD.

## Ejecución del flujo

```bash
flow.tcl -design ASIC_DETECCION_FALLAS
```

---

# Resultados obtenidos

- Síntesis lógica completada correctamente
- Floorplan generado
- Placement realizado
- Routing completado
- STA ejecutado
- Layout GDSII generado exitosamente

---

# Archivos importantes

| Archivo | Descripción |
|---|---|
| `top.sv` | Módulo principal |
| `tb_top.sv` | Testbench principal |
| `top.gds` | Layout final GDSII |
| `timing.rpt` | Reporte STA |
| `power.rpt` | Reporte de potencia |

---



# Autor

Francisco Alberto Perez Hernandez 

Estudiante de Ingeniería Electrónica enfocado en:
- Diseño ASIC
- FPGA
- Firmware
- VLSI
- Semiconductores
