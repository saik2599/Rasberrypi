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





#################################
Note:

Optional Adjustments:
If you want to avoid the interface renaming or confusion:

Rename eth1 Back to usb0: Add a udev rule to keep the interface name consistent:

#bash: sudo nano /etc/udev/rules.d/70-persistent-net.rules

Add the following line for the Quectel modem:

makefile
Copy code
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="f2:3f:4e:a4:0a:4f", NAME="usb0"

Replace f2:3f:4e:a4:0a:4f with the MAC address of eth1.

Save 

#bash: reboot



############################################

Install speedtest-cli

#bash: sudo apt install speedtest-cli -y

Explicitly Use the Correct Interface
Sometimes, speedtest-cli does not properly handle the --source option. To force it to use the modem, temporarily disable other network interfaces:

#bash: sudo ifconfig wlan0 down

#bash: speedtest-cli




Debug with Curl

Use curl to manually fetch a speed test file:

#bash: curl --interface usb0 -o /dev/null http://speedtest.tele2.net/10MB.zip


