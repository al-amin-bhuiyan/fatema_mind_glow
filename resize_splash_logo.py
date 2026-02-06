from PIL import Image
import os

# Paths
input_path = r"assets/images/splash_logo_2.png"
output_path = r"assets/images/splash_logo_small.png"

# Load the original image
img = Image.open(input_path)
original_width, original_height = img.size

print(f"Original size: {original_width}x{original_height}")

# Target display size in dp: 240x64
# For mdpi (160dpi), 1dp = 1px
# For xxxhdpi (640dpi), 1dp = 4px
# We'll create a 960x256 image (240dp x 64dp at xxxhdpi = 4x scale)
# This ensures high quality on all screen densities

target_width = 960  # 240dp * 4 (xxxhdpi)
target_height = 256  # 64dp * 4 (xxxhdpi)

# Calculate the aspect ratio
aspect_ratio = original_width / original_height
target_aspect = target_width / target_height

# Resize the logo to fit within the target dimensions while maintaining aspect ratio
if aspect_ratio > target_aspect:
    # Width is the limiting factor
    new_width = target_width
    new_height = int(target_width / aspect_ratio)
else:
    # Height is the limiting factor
    new_height = target_height
    new_width = int(target_height * aspect_ratio)

# Resize the image with high quality
resized_img = img.resize((new_width, new_height), Image.Resampling.LANCZOS)

# Create a new transparent canvas with target size
final_img = Image.new('RGBA', (target_width, target_height), (255, 255, 255, 0))

# Center the resized image on the canvas
x_offset = (target_width - new_width) // 2
y_offset = (target_height - new_height) // 2
final_img.paste(resized_img, (x_offset, y_offset), resized_img if resized_img.mode == 'RGBA' else None)

# Save the result
final_img.save(output_path, 'PNG', optimize=True)
print(f"Created smaller splash logo: {output_path}")
print(f"New size: {target_width}x{target_height}")
print(f"Logo rendered at: {new_width}x{new_height}")
