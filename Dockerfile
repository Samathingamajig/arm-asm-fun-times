FROM arm64v8/ubuntu:latest
RUN apt-get update && apt-get install -y \
    bash \
    # cmake \
    python3 \
    g++ \
    gcc \
    gdb \
    make \
    # openssh-server \
    # rsync \
    # software-properties-common \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# # Set the root password for the SSH server (CHANGE THIS PASSWORD!)
# RUN echo 'root:your_password_here' | chpasswd

# # Permit root login via SSH
# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# # Enable password authentication
# RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# RUN service ssh start

# # SSH port
# EXPOSE 22

RUN echo "set auto-load local-gdbinit\nset auto-load safe-path /" >> ~/.gdbinit

# COPY .gdbinit .gitignore Makefile a64_testbench.o scratch.c student_a64_template.s verify.py ./
COPY ./src/hello-world.s ./src/

# RUN make
