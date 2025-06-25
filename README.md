 Virtual Embedded Sensor Hub SoC with Low Power AI Anomaly Detection

This project simulates a Virtual Embedded Sensor Hub System-on-Chip (SoC) integrated with AI-based anomaly detection, targeting industrial machinery, wearable health devices, satellite systems, and smart environmental monitors — where low power and intelligent monitoring are essential.


# Project Aim

To design and simulate a low-power embedded system that can:

Continuously monitor sensor signals,

Detect anomalies using machine learning trained on normal data,

Minimize power consumption via FSM-controlled logic,

Trigger UART alerts during abnormal conditions,

Enable future deployment on microcontrollers, FPGAs, or real hardware.


# Real-World Implementation Vision

This simulated project represents the logic and behavior of a real embedded device that would operate in the following environments:

# Application	Functionality

1 Satellites	Detect temperature or radiation anomalies in orbit
2 Industrial Machines	Identify early mechanical or thermal failure signs
3 Wearables (e.g., smartwatches)	Monitor health vitals (e.g., heartbeat, oxygen level)
4 Smart Water Systems	Detect sudden pollution, chemical leakage, or turbidity rise


# In real devices:

The FSM logic would run on a microcontroller (e.g., STM32, ESP32).

The ML inference would be optimized using TinyML (TensorFlow Lite) or via co-processor.

UART output would be used to communicate with a display, logger, or cloud module (e.g., ESP32 Wi-Fi).



---

🛠️ Features

✅ Dataset simulating 1-day of sensor readings (1000+ entries)
✅ Python ML model trained on normal patterns to identify outliers
✅ FSM in Verilog HDL to model low-power state transitions
✅ Sleep Mode to reduce energy usage when idle
✅ UART output for alert signaling (ASCII: '0', '1', 'A')
✅ AI output text file used as input to FSM testbench
✅ Designed for real hardware translation (FPGA/MCU)



🔋 Power-Aware FSM Logic

Your FSM smartly manages power depending on system state:

State	Role	Sensor	Power Usage	UART Output

SLEEP	Idle / no data	Disabled	🔋 Very Low	'0'
ACTIVE	Normal pattern	Enabled	🔋 Moderate	'1'
ALERT	Anomaly detected	Disabled	🔋 Brief High	'A'


Entering sleep avoids wasting energy.

Anomalies are prioritized with fast transitions and alert flags.

UART acts as communication channel for external systems.



📊 AI Model Overview

Trained on sensor data representing 24 hours of normal behavior

Uses sklearn Isolation Forest / Logistic Regression to detect outliers

Output:

0: Normal

1: Anomaly

2: No sensor data


Saved as ai_output.txt → read into Verilog testbench for FSM simulation


# Integration Flow (Python ↔ Verilog)

1. Python script generates simulated sensor data


2. ML model predicts anomalies and saves output to ai_output.txt


3. Verilog testbench reads this file in ModelSim


4. FSM updates state and sends UART output accordingly


5. Real devices can later use this logic with minimal changes


# Tech Stack

Component	Technology Used

SoC Design	Verilog HDL (ModelSim)
AI Model	Python (scikit-learn)
Data Generation	Python script (sensor simulator)
Data Analysis	Jupyter Notebook
Integration	File-based Python ↔ Verilog I/O
Future Hardware	ESP32 / STM32 / FPGA + UART



# Future Enhancements

1. Cocotb for Python-based real-time testbench with sensor simulation
2. UART Interface to ESP32 for cloud or mobile alert system
3. Power profiling using FPGA power estimation tools
4. Deploying AI model on microcontroller using TensorFlow Lite


