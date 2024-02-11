# Use TensorFlow's provided image with GPU support and Jupyter
FROM tensorflow/tensorflow:2.10.0-gpu-jupyter

RUN apt update && apt upgrade -y

# Run updates and install your desired packages
RUN apt-get update && apt-get install -y \
    vim \
    libgl1-mesa-glx \
    libcairo2 \
    libgirepository1.0-dev \
    libgtk-3-dev \
    python3-gi \
    python3-gi-cairo \
    gir1.2-gtk-3.0 \
    python3-tk \
    # Additional packages for broader GUI support
    xvfb \
    xauth \
    xorg \
    dbus-x11 \
    x11-xserver-utils \
    libxext-dev \
    libxrender1 \
    libxtst6 \
    libfreetype6-dev \
    libfontconfig1 \
    libxcb1-dev \
    libx11-dev \
    # For Qt-based applications
    qtbase5-dev \
    qtchooser \
    qt5-qmake \
    qtbase5-dev-tools \
    # Clean up
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir remotezip tqdm opencv-python einops matplotlib numpy
RUN python3 -m pip install --upgrade pip

# Add alias to .bashrc
RUN echo "alias lt='ls -lrth'" >> ~/.bashrc

# Set the working directory (optional)
WORKDIR /data

# Expose Jupyter port
EXPOSE 8888

# Start Jupyter Notebook (You can customize this command based on your needs)
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
