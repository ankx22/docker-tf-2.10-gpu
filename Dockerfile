# Use TensorFlow's provided image with GPU support and Jupyter
FROM tensorflow/tensorflow:2.10.0-gpu-jupyter

# Run updates and install your desired packages
RUN apt-get update && apt-get install -y \
    vim \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir remotezip tqdm opencv-python einops matplotlib numpy
RUN python3 -m pip install --upgrade pip

# Add alias to .bashrc
RUN echo "alias lt='ls -lt'" >> ~/.bashrc

# Set the working directory (optional)
WORKDIR /data

# Expose Jupyter port
EXPOSE 8888

# Start Jupyter Notebook (You can customize this command based on your needs)
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
