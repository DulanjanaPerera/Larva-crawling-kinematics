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

- **`update_simulink_parameters.m`**  
  Interface between MATLAB optimization outputs and Simulink/Simscape model parameters.

- **`robotic_larva_simscape.slx`**  
  Simscape Multibody model for visualization and kinematic validation. The SolidWorks folder has to be in the same folder.

- **`plotting_gait_muscle.m`**  
  Utilities for reproducing plots and analysis figures.

- **`linesFor4barmechanism.m`**
  The script to draw the 4-bar mechanism for given lengths and angles.

- **`shadedErrorBar.m`**
  The script that draw the shaded error bar
  *Rob Campbell (2026). raacampbell/shadedErrorBar (https://github.com/raacampbell/shadedErrorBar), GitHub. Retrieved January 22, 2026.*
  
- **`structureAngles.m`**
  Compute the angles of the 4-bar mechanism for given lengths.

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

---

# Modeling overview
## Forward kinematics

Each larva body segment is modeled as an extensible planar 4-bar mechanism whose links represent muscle elements. The configuration of a segment is parameterized by the vector of spring (muscle) lengths:

`l = [l1, l2, l3, l4, l5]`


where:

- l1–l4 correspond to the primary muscle elements, and 
- l5 is an auxiliary element used to compute internal trapezoidal angles.

Two forward kinematic mappings are constructed by traversing the kinematic chain in opposite directions to compute the position of the protopodium point. A closure constraint enforces consistency between these two mappings, ensuring that the mechanism forms a valid closed chain.

## Inverse kinematics via optimization

Because this extensible 4-bar mechanism does not admit a closed-form inverse kinematic solution, the inverse problem is solved using *constrained nonlinear optimization*.

At each time step, muscle lengths are estimated by minimizing a cost function composed of three terms:

- Closure consistency
  Penalizes mismatch between the two forward kinematic paths.

- Trajectory tracking error
  Penalizes deviation between the predicted protopodium position and the experimentally measured trajectory.

- Elastic energy regularization
  Penalizes large deviations from nominal muscle lengths.

The optimization is solved subject to physiologically feasible bounds on muscle lengths, which are obtained from experimental imaging data.

## Full-body crawling via segment delay

Rather than solving inverse kinematics independently for each body segment, a **single-segment solution** is propagated along the body using a **transport delay**. This delay introduces a phase shift between adjacent segments, producing a peristaltic crawling wave along the larva body.

This approach significantly reduces computational cost while preserving realistic crawling kinematics.
