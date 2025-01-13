#!/bin/bash

# Function to remove conda environment if it exists
remove_conda_env() {
    env_name=$1
    if conda env list | grep -q "$env_name"; then
        echo "Removing conda environment: $env_name"
        conda remove --name "$env_name" --all -y
    else
        echo "Conda environment $env_name does not exist."
    fi
}

# Function to remove global Python installation if it exists
remove_global_python() {
    python_path=$1
    if [ -d "$python_path" ]; then
        echo "Removing global Python installation: $python_path"
        rm -rf "$python_path"
    else
        echo "Global Python installation $python_path does not exist."
    fi
}

# Remove conda environments
remove_conda_env "automl_env"
remove_conda_env "base"
remove_conda_env "spacyenv"

# Remove global Python installations
remove_global_python "/usr/local/bin/python3.11"
remove_global_python "/usr/bin/python3.9"

# Create a new conda environment with Python 3.12.4
echo "Creating new environment my_env with Python 3.12.4..."
conda create --name my_env python=3.12.4 -y

# Activate the new environment
source activate my_env

# Install recent machine learning libraries and packages
echo "Installing machine learning libraries..."
conda install numpy pandas scikit-learn tensorflow keras pytorch torchvision matplotlib seaborn -y
conda install -c conda-forge jupyterlab -y

# Verify installation
echo "Verifying installation..."
conda list

echo "Setup complete. Environment my_env is ready to use."

