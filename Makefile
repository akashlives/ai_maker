# Set the conda environment name
CONDA_ENV_NAME = ai_maker

## Set up commands
# Set the conda command
CONDA_CMD = conda

# Set the activate command based on the operating system
ifeq ($(OS),Windows_NT)
	ACTIVATE_CMD = $(CONDA_CMD) activate
else ifeq ($(shell uname -s),Darwin)
	ACTIVATE_CMD = $(CONDA_CMD) activate
else
	ACTIVATE_CMD = source activate
endif

# Set the poetry command
POETRY_CMD = poetry

# Set the default target
.DEFAULT_GOAL := run

# Create the conda environment
create-env:
	$(CONDA_CMD) create --name $(CONDA_ENV_NAME)

# Activate the conda environment
activate-env:
	$(ACTIVATE_CMD) $(CONDA_ENV_NAME)

# Deactivate the conda environment
deactivate-env:
	$(CONDA_CMD) deactivate

# Install dependencies in the conda environment using conda
install-deps-conda:
	$(CONDA_CMD) install --name $(CONDA_ENV_NAME) < requirements.txt

# Install dependencies in the conda environment using poetry
install-deps-poetry:
	$(POETRY_CMD) install

# Check for Poetry and install if not found
check-poetry:
	@echo "Checking for Poetry..."
	@which poetry || (echo "Poetry not found, installing..." && conda install -c conda-forge poetry)

# Initialize a new Poetry project
init-project: check-poetry
	@echo "Initializing new Poetry project..."
	@poetry init --no-interaction