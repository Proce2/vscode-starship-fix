FROM mcr.microsoft.com/powershell:lts-nanoserver-1809

# Set environment variables for a consistent HOME
ENV HOME="C:\\Users\\ContainerAdministrator"

SHELL ["pwsh", "-Command"]

# Copy your repo into the container
COPY . C:\\setup
WORKDIR C:\\setup

# Run the installer
RUN .\\install.ps1

CMD ["pwsh.exe", "-NoExit"]
