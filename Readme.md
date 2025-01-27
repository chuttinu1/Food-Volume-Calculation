# Food Volume Calculation Project

This project calculates the volume of food objects from videos using **MATLAB** and **Python**.

## Overview
This project processes videos of food objects, performs 3D reconstruction using **Structure from Motion (SfM)** technology, and calculates their volume using the **convex hull** method. You can use any mobile camera to capture the video, and a finger can be used as a reference object for scale. The project uses **MATLAB** for the volume calculation, and optional **Python** scripts can be used for additional processing, such as background removal of images.

## Technologies Used:
- **MATLAB**: For processing videos, 3D reconstruction (SfM), and volume calculation using convex hull.
- **Python**: For background removal of 2 images (optional).

## How to Use

1. **Prepare Input Videos**: 
   - You can use any mobile camera to capture the video of the food object.
   - Place the video files in the `project_code/` folder.
   - Make sure to use a finger as a reference object in the video for accurate volume scaling.

2. **Configure Python Path (if needed)**: 
   - If MATLAB doesn't automatically detect the correct Python version or if you have a custom installation, you may need to specify the location of your Python installation.
   - To do this, open `back_remover.m` in MATLAB and add this line (replace with your Python path):
     ```matlab
     pyenv('Version', 'C:/path/to/your/python.exe');
     ```

3. **Run the MATLAB Script**:
   - Open **MATLAB**.
   - Set the working directory to the `MATLAB/` folder.
   - Run the script `main.m` by typing the following in MATLAB:
     ```matlab
     run('main.m');
     ```
     ```

## How It Works

1. **Capture Video**: You can use any mobile camera to capture the video of a food object. The system will use a **finger** as a reference object to scale the volume.
2. **3D Reconstruction with SfM**: The project applies **Structure from Motion (SfM)** technology to reconstruct the 3D model of the food object from the video frames.
3. **Convex Hull Volume Calculation**: After 3D reconstruction, the **convex hull method** is used to calculate the volume of the food object.

## Project Files:
- **`main.m`**: Main MATLAB script for food volume calculation.
- **`.mp4 file/`**:  Your input video files of food objects.
- **`Python/`**: (Optional) Folder for Python utilities (e.g., `remove.py`).
- **Other MATLAB files**: Additional MATLAB scripts used in the volume calculation process.

## License
This project is licensed under the [MIT License](LICENSE).

## Contact
If you have any questions or feedback, feel free to contact me at [tarindunu1@gmail.com].
