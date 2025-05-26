# 🚦 Smart Traffic Light Controller (FPGA-Based)

This project implements a **Smart Traffic Light Controller** using Verilog HDL, targeting an FPGA development board (such as Nexys A7). It dynamically manages a four-way traffic junction by analyzing **traffic density**, **vehicle presence**, and **emergency overrides**, with real-time visual outputs using LEDs and a 7-segment display.

---

## 🌍 Real-Life Importance

Traditional traffic lights operate on fixed timing, often leading to inefficiencies such as:
- Wasted green signal time on empty roads
- Congestion buildup during peak hours
- Delay for emergency vehicles

This Smart Traffic Light Controller enhances **urban mobility and road safety** through:
- **Dynamic timing** based on traffic conditions
- **Priority handling** of emergency vehicles
- **Power-efficient and testable design**, suitable for future smart city integration

---

## 🛠️ System Features

- ✅ 4-way intersection control: Roads A, B, C, D
- ✅ Inputs:
  - `VA–VD`: Vehicle presence sensors (1 bit each)
  - `TA–TD`: Traffic density (2 bits per road)
  - `emg_mode`: Emergency override signal
  - `ER`: Emergency road selector (2 bits)
- ✅ Outputs:
  - `GA–GD`: Green lights
  - `YA–YD`: Yellow lights
  - `RA–RD`: Red lights
  - `seg[6:0]`: 7-segment display for countdown
  - `timer_out[7:0]`: Optional debug timer output
- ✅ Reset and clock synchronization
- ✅ Emergency override logic: Priority to emergency vehicle road
- ✅ Sequential traffic control with dynamic green light duration based on density
- ✅ Built-in countdown timer using 7-segment display

---

## ⚙️ Working Principle

1. **Normal Mode**:
   - Controller checks vehicle presence and traffic density on all roads.
   - Allocates green time proportionally based on density (2-bit input per road).
   - Only one road gets green at a time; others are on red.
   - Yellow light appears before switching to the next road.
   - Cycle continues indefinitely, prioritizing roads with more traffic.

2. **Emergency Mode**:
   - If `emg_mode` is HIGH:
     - Green signal is given to the road specified by `ER[1:0]`.
     - All other roads stay red until `emg_mode` is deactivated.
     - Used for ambulances, fire trucks, etc.

3. **Reset**:
   - Resets the system state and restarts normal operation.

---

## 🧠 Technical Concepts Implemented

- ✅ **Power Optimization**:
  - Clocks gated when not in use
  - Minimal switching logic for lights and timers

- ✅ **Design for Test (DFT)**:
  - Scan-chain based architecture for easy test vector application
  - Simple control logic insertion for testability

- ✅ **Static Timing Analysis (STA)**:
  - Critical path minimization for faster operation
  - Timing-closure ensured using Vivado implementation reports

---

## 🔌 FPGA Pin Mapping

All pins are mapped in the `constraints/traffic_pins.xdc` file. These include:
- Inputs: `clk`, `rst`, `VA–VD`, `TA–TD`, `emg_mode`, `ER`
- Outputs: `GA–GD`, `YA–YD`, `RA–RD`, `seg[6:0]`, `timer_out[7:0]`

Refer to the `.xdc` file for specific FPGA package pins used (compatible with Nexys A7).

---


---

## 🚀 How to Run

1. Open Vivado and create a new RTL project.
2. Add all Verilog files from `/src`.
3. Add the `traffic_pins.xdc` from `/constraints`.
4. Synthesize, implement, and generate bitstream.
5. Program the FPGA board and observe:
   - Green/Yellow/Red LEDs based on real-time traffic inputs
   - Countdown on the 7-segment display
   - Emergency override behavior when triggered

---

## 📜 License

MIT License – feel free to use, modify, or extend this project with credit.

---

## ✨ Future Enhancements

- Integration with camera-based traffic detection using AI
- IoT-based real-time control via Wi-Fi
- Pedestrian signal and walk button interface
- Web dashboard for monitoring signal status and logs

---

**Designed with the future of smart mobility in mind.**
