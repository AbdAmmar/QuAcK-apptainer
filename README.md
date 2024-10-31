# QuAcK Apptainer Container

<img src="logo/logo_quack.png"  width="250">

## Overview

This repository provides an Apptainer (formerly Singularity) container for [QuAcK](https://github.com/pfloos/QuAcK/). 
The container allows users to easily install and execute QuAcK on HPC clusters within a consistent and reproducible environment.

## Building the Image

Before starting, make sure you have Apptainer installed on your system.
If not, you can install it by following the instructions from the [official Apptainer documentation](https://apptainer.org/docs/user/main/installation.html).
To build the Apptainer image (SIF file) for QuAcK, follow these steps:

1. **Clone the Repository**: Clone this repository to your machine.
    ```bash
    git clone https://github.com/AbdAmmar/QuAck-apptainer.git
    cd QuAck-apptainer
    ```

2. **Build the Image**: Use the Apptainer `build` command to create the SIF file.
    ```bash
    apptainer build quack.sif quack.def
    ```
    
    This command will create an image file named `quack.sif` based on the definitions provided in the `quack.def` file.

## Running a Calculation

Once you have built the Apptainer image, you can run QuAcK to perform calculations by following these steps:

1. **Prepare Input for QuAcK**: QuAcK requires users to provide a molecular geometry, along with a file containing the
   [methods](https://github.com/pfloos/QuAcK/blob/master/input/methods.default) and a file with the
   [options](https://github.com/pfloos/QuAcK/blob/master/input/options.default) for the calculation. These files should be placed in a working directory, for example named `work_quack`.

3. **Run the Calculation**: Launch QuAcK using the following command:
   ```bash
   apptainer run --cleanenv --no-mount home,cwd --bind path_to_work_quack quack.sif python3 PyDuck.py --working_dir path_to_work_quack arguments

  In this command:
  - `--cleanenv` ensures a clean environment for the execution.
  - `--no-mount home,cwd` prevents mounting your home directory and current working directory for security and reproducibility.
  - `--bind path_to_work_quack` binds your working directory to the container, allowing access to input files.
  - `arguments` should be replaced with the specific options for your calculation.

  To see all available options for the arguments, you can execute:
   ```bash
   apptainer run --cleanenv --no-mount home,cwd --bind path_to_work_quack uack.sif python3 PyDuck.py --help
   ```

### Example

In this section, we provide an example of running a Self-Consistent Field (SCF) calculation using the "cc-pvqz" basis set for a water molecule.

#### Step 1: Create a Working Directory

First, create a working directory named, for instance, `work_quack`:

```bash
mkdir work_quack
```

Next, navigate into this directory and prepare the input files.

#### Step 2: Prepare the Molecular Geometry

Inside the work_quack directory, create a subdirectory for the molecular geometry:
```bash
cd work_quack
mkdir mol && cd mol
```

Then, create a file named `H2O.xyz` to store the geometry in Angstroms:
```bash
touch H2O.xyz
```

#### Step 3: Prepare Input Files

Navigate back to the `work_quack` directory and create a subdirectory for input files:
```bash
cd ..
mkdir input && cd input
```
Download the template files for `methods` and `options` from the QuAcK repository:
```bash
curl -o options https://raw.githubusercontent.com/pfloos/QuAcK/master/input/options.default
curl -o methods https://raw.githubusercontent.com/pfloos/QuAcK/master/input/methods.default
```
Open the `methods` file and set `RHF` to `T` (True).

#### Step 4: Launch the Calculation

Now you are ready to launch the calculation. Navigate back to the main directory:
```bash
cd ../..
```

Run the following command to execute the SCF calculation:
```bash
apptainer run --cleanenv --no-mount home,cwd --bind $PWD/work_quack quack.sif python3 PyDuck.py --working_dir $PWD/work_quack -b "cc-pvqz" -x "H2O"
```
Here, the command `$PWD` ensures that you are providing the absolute path to the working directory.



<img src="https://lcpq.github.io/PTEROSOR/img/ERC.png" width="200" />

QuAcK is supported by the [PTEROSOR](https://lcpq.github.io/PTEROSOR/) project that has received funding from the European Research Council (ERC) under the European Union’s Horizon 2020 research and innovation programme (Grant agreement No. 863481).

