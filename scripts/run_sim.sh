#!/bin/bash

echo "==============================="
echo " Compilando diseño..."
echo "==============================="

iverilog -g2012 -o sim/output.vvp rtl/*.sv tb/tb_top_3.sv

if [ $? -ne 0 ]; then
    echo "Error en compilación"
    exit 1
fi

echo ""
echo "==============================="
echo " Ejecutando simulación..."
echo "==============================="

vvp sim/output.vvp

if [ $? -ne 0 ]; then
    echo "Error en simulación"
    exit 1
fi

echo ""
echo "==============================="
echo " Abriendo GTKWave..."
echo "==============================="

gtkwave sim/wave.vcd
