# Larva Crawling Kinematics (Extensible 4-Bar Model)

This repository implements a reduced-order **planar kinematic model** of *Drosophila* larva crawling, based on an **extensible 4-bar mechanism** whose links are modeled as springs (muscle analogs). The pipeline supports:

- Forward kinematics of the protopodium point from spring lengths  
- Inverse kinematics via constrained optimization to match measured trajectories  
- Propagation of a single-segment gait along the body using a transport delay (full-body crawling)

---

## Repository layout

Typical roles of the key files:

- **`main.m`**  
  Primary entry point to run the workflow (data → preprocessing → inverse kinematics → visualization).

- **`forwardModel.m`**  
  Forward kinematics utilities for the extensible 4-bar mechanism (computing protopodium pose/position from spring lengths).

- **`optimization_model_prediction.m`**  
  Inverse kinematics and parameter identification using constrained optimization (tracking + closure + energy terms).

- **`process_data_and_fit_spline.m`**  
  Data cleaning and spline fitting to smooth tracked trajectories prior to optimization.

- **`update_simulink_parameters.m`**  
  Interface between MATLAB optimization outputs and Simulink/Simscape model parameters.

- **`larva_simulation.slx`**  
  Simscape Multibody model for visualization and kinematic validation.

- **`drosophila_data.mat`**  
  Example dataset containing tracked larval motion data.

- **`test_traj.m`**  
  Script for generating or validating reference trajectories.

- **`figure_generation.m`**  
  Utilities for reproducing plots and analysis figures.

---

## Requirements

- MATLAB  
- Toolboxes (depending on usage):
  - Optimization Toolbox  
  - Simscape Multibody  

---

## Quick start

1. Clone the repository:
   ```bash
   git clone https://github.com/DulanjanaPerera/Larva-crawling-kinematics.git
   cd Larva-crawling-kinematics
