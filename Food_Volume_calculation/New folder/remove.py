from rembg import remove
from PIL import Image
import os

# Define the source folder and the output folder
source_folder = 'video_frames'
output_folder = 'processed_images'

# Create the output folder if it doesn't exist
if not os.path.exists(output_folder):
    os.makedirs(output_folder)

# List all files in the source folder
input_images = [f for f in os.listdir(source_folder) if f.endswith(('.png', '.jpg', '.jpeg'))]
output_images = [os.path.join(output_folder, f"processed_{f}") for f in input_images]

# Ensure the input and output lists are the same length
if len(input_images) != len(output_images):
    raise ValueError("The number of input images must match the number of output images.")

# Process each image
for input_path, output_path in zip(input_images, output_images):
    try:
        # Construct full file paths
        full_input_path = os.path.join(source_folder, input_path)
        # Open the image
        img = Image.open(full_input_path)

        # Remove background
        result = remove(img)

        # Save the output image
        result.save(output_path)
        print(f"Processed {full_input_path} and saved to {output_path}")
    except Exception as e:
        print(f"Failed to process {full_input_path}: {e}")

print("Background removal completed and images saved in the new folder.")
