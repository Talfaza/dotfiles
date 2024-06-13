FROM fedora:39

RUN dnf update -y && \
    dnf install -y git 


# Define the default command to run when the container starts
CMD ["bash"]
