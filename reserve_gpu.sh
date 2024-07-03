#!/bin/bash

# Default number of GPUs
DEFAULT_GPUS=2

# Check if a number of GPUs was provided as an argument
if [ -z "$1" ]; then
  GPUS=$DEFAULT_GPUS
else
  GPUS=$1
fi

# Print a message indicating the number of GPUs being reserved
echo "Reserving $GPUS GPU(s)..."

# Execute the srun command with the specified or default number of GPUs
srun --gpus=$GPUS -c 32 --mem 64G --pty bash

