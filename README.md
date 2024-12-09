# Rasberrypi
Script to Enable the Quectel Modem and Ethernet connection.



Log in to your Raspberry Pi
Open a terminal or SSH into your Raspberry Pi.
Step 1: Ensure you have root privileges by running:

#bash: sudo su

Step 2: Create the Script File
Create a new script file:

#bash: nano setup_ethernet_modem.sh


Step 3: Make the Script Executable
Grant execute permissions to the script:

#bash: chmod +x setup_ethernet_modem.sh

Step 4: Run the Script
Execute the script:

#bash: ./setup_ethernet_modem.sh


Step 5: Follow the Output

Watch for messages like:
"Quectel Modem already setup" (if already configured).
"Ethernet connection already configured" (if already set up).
Errors or other configuration messages.


Step 6: Restart the Raspberry Pi
Once the script completes successfully, reboot your system for changes to take full effect:

#bash: reboot
