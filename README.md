# Google Cloud Run | Django Project Initialization Script

## Overview
This Bash script helps initialize and configure a Django project quickly by renaming template directories, updating references within Python files, verifying Python dependencies, and setting up a Python virtual environment. It streamlines the transition from a Cloud Run Django template (`helloproject` and `helloapp`) to your own project and app names.

---

## Features
- Interactive prompts for project and app names.
- Automated directory renaming (`helloproject` → your project name, `helloapp` → your app name).
- Updates Python file references to reflect new names.
- Modifies the `manage.py` file to match the new project and app configuration.
- Checks for Python3 and installs required dependencies (`python3-dev`).
- Creates a Python virtual environment.

---

## Requirements
- Linux OS (preferably Debian-based).
- Bash shell.
- `python3` and `python3-dev` packages.
- `virtualenv` capability (`python3 -m venv`).

---

## Usage

1. **Clone or download** the template project containing the script.

2. **Make the script executable**:
```bash
chmod +x cloud_run_project_renamer.sh
```

3. **Run the script**:
```bash
./cloud_run_project_renamer.sh
```

4. Follow the interactive prompts to enter your desired project and app names.

5. Select from the available operations:
   - Rename directories
   - Update Python references
   - Update `manage.py`
   - Check and install Python dependencies
   - Create a virtual environment
   - Run all operations

---

## Example
```
$ ./cloud_run_project_renamer.sh

Enter the project name (default: your_project_name): myproject
Enter the app name (default: your_app_name): myapp

Select the operation you want to perform:
1) Rename directories
2) Update Python references in directories (project and app)
3) Update manage.py file
4) Check python environment and install dependencies
5) Create virtual environment
6) Run all operations
0) Exit

Enter your choice (0-6): 6
```

---

## License
This script is licensed under the **AGPL v3.0.0**.

- [Full License](https://www.gnu.org/licenses/agpl-3.0.en.html)

---

## Support and Contact
For questions or support, please contact:
- **Email**: [solengdev@tagntrakit.com](mailto:solengdev@tagntrakit.com), [enquiries@tagntrakit.com](mailto:enquiries@tagntrakit.com)
- **Website**: [Tag N Trak It](https://www.tagntrakit.com)

*Crafted with care by TNTIT-Shamir © 2025 Tag N Trak It - Australia.*

