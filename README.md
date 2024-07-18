# Acer RGB Control Menu

**Version:** v1.0.0

This script provides a menu interface to control RGB lighting effects on Acer Predator keyboards using the [acer-predator-turbo-and-rgb-keyboard-linux-module](https://github.com/JafarAkhondali/acer-predator-turbo-and-rgb-keyboard-linux-module).

## Features

- Select from 6 lighting effects
- Choose red, blue, or green colors
- Adjust animation speed (1-9)
- Configure zones (1-4 or all)
- Save profiles
- List saved profiles
- Load saved profiles

## Getting Started

1. **Clone the Repository:**
   ```
   git clone https://github.com/JafarAkhondali/acer-predator-turbo-and-rgb-keyboard-linux-module.git
   cd acer-predator-turbo-and-rgb-keyboard-linux-module
   ```

2. **Prepare the Script:**

   Ensure `facer_rgb.py` (from the linked repository) is in the same directory as your script (`acer-rgb.sh` or `acer-rgb`).

   If you need to rename your script for convenience:
   ```
   mv acer-rgb.sh acer-rgb
   ```

3. **Make the Script Executable:**
   ```
   chmod +x acer-rgb
   ```

4. **Move the Script to a Directory in Your PATH:**

   To run `acer-rgb` from anywhere without specifying the path, move it to a directory that is listed in your system's PATH (e.g., `/usr/local/bin/`):
   ```bash
   sudo mv acer-rgb /usr/local/bin/
   ```

## Usage

Now, you can run `acer-rgb` from any terminal session by typing:
```
acer-rgb
```

Follow the on-screen menu options to control your Acer Predator keyboard's RGB lighting.

If you encounter any issues or have suggestions, please visit the [acer-rgb-menu](https://github.com/Zeaksblog/acer-rgb-menu) repository.