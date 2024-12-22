# Wardrive Script

A simple Bash script for wardriving, enabling Wi-Fi monitor mode, capturing network data, and restoring managed mode after scanning.

## Description

This project automates the process of switching your Wi-Fi interface to monitor mode, capturing network traffic using `airodump-ng`, and saving the results in a CSV file. The captured data can be uploaded to [Wigle.net](https://wigle.net) for mapping wireless networks. The script ensures your Wi-Fi card is restored to normal operation after use.

## Getting Started

### Dependencies

* Ubuntu-based operating system.
* Wireless card that supports monitor mode.
* `aircrack-ng` package:

```
sudo apt update && sudo apt install aircrack-ng
```


### Installing

* Clone the repository:

```
git clone https://github.com/SmellyNayohn/WarDriving.git
```

##Add your Wifi Interface : (Know it with command : ```iwconfig``` )
```
ORIGINAL_INTERFACE=""  # Your Wi-Fi interface
```


### Executing program

* Run the script with `sudo`:
```
sudo ./wardriving.sh
```

* Enter a custom file name when prompted, or press Enter to use the default name.
* Press `Ctrl+C` to stop scanning. The CSV file will be saved in the same directory as the script.

## Help

* If you encounter any issues, make sure your wireless card supports monitor mode and that `aircrack-ng` is properly installed.
* You can always check the status of your interface with the following command:
