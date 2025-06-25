 Virtual Embedded Sensor Hub SoC with Low Power AI Anomaly Detection

This project simulates a **Virtual Embedded Sensor Hub System-on-Chip (SoC) integrated with AI-based anomaly detection**, targeting industrial, and wearable applications etc .. ** where low power and intelligent monitoring are essential

# Project Aim

To design and simulate a **low-power intelligent system** that can:

- Continuously monitor sensor data,
- Detect abnormal patterns using AI trained on normal behavior,
- Minimize power usage during idle or no-sensor periods,
- Trigger alerts during anomalies using UART for external action.

> **Real-world relevance**: This project mimics embedded AI behavior found in:
> **Satellites** (e.g., thermal or radiation monitoring)
> **Industrial Machines** (e.g., predictive maintenance)
> **Wearables** (e.g., irregular heartbeat detection)
> **Smart Environmental Stations** (e.g., water pollution detection)

 # Features

✅ simulated dataset for model training  
✅ Sensor data generation using Python  
✅ AI model trained on normal behavior, flags anomalies  
✅ Verilog FSM simulates power-optimized SoC logic  
✅ UART output to communicate FSM state  
✅ Idle periods enter **sleep mode** to conserve power  
✅ Integration between Python and Verilog via text file  


#Power-Aware FSM Logic

The Verilog FSM simulates power behavior:

| FSM State | Description        | Sensor Activity | Power Usage     |
|-----------|--------------------|------------------|------------------|
| SLEEP     | No data or idle     | OFF              | 🔋 Very Low      |
| ACTIVE    | Normal data         | ON               | 🔋 Moderate      |
| ALERT     | Anomaly detected    | OFF              | 🔋 High (brief)  |

- **Sleep state** ensures sensor modules are disabled.
- **Active state** keeps them on only when useful.
- **Alert state** flags serious issues quickly and resets.

This **virtual power model** helps mimic low-power SoC operation without real current measurement.


# Tech Stack

| Component        | Technology Used                |
|------------------|--------------------------------|
| SoC Design       | Verilog HDL (ModelSim)         |
| AI Model         | Python, scikit-learn           |
| Dataset          | Simulated values (1000+ entries) |
| Data Analysis    | Jupyter Notebook               |
| Integration      | Text file I/O (`ai_output.txt`) |
| Editor           | Visual Studio Code             |                |
