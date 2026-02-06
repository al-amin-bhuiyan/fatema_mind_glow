from PIL import Image
import os

# Paths
input_path = r"assets/images/splash_logo.png"
output_path = r"assets/images/splash_logo_native.png"

try:
    # Load the original image
    img = Image.open(input_path)
    
    # Convert to RGBA if not already
    if img.mode != 'RGBA':
        img = img.convert('RGBA')
    
    original_width, original_height = img.size
    print(f"Original size: {original_width}x{original_height}")
    
    # Calculate new size - scale down to 70% of original
    scale_factor = 0.7
    new_width = int(original_width * scale_factor)
    new_height = int(original_height * scale_factor)
    
    print(f"Scaled size: {new_width}x{new_height}")
    
    # Resize with high quality
    resized_img = img.resize((new_width, new_height), Image.Resampling.LANCZOS)
    
    # Create a canvas with 30% transparent padding around the logo
    padding_factor = 1.5  # 150% of scaled size to add padding
    canvas_width = int(new_width * padding_factor)
    canvas_height = int(new_height * padding_factor)
    
    # Create transparent canvas
    final_img = Image.new('RGBA', (canvas_width, canvas_height), (0, 0, 0, 0))
    
    # Center the resized logo on the canvas
    x_offset = (canvas_width - new_width) // 2
    y_offset = (canvas_height - new_height) // 2
    final_img.paste(resized_img, (x_offset, y_offset), resized_img)
    
    # Save the result
    final_img.save(output_path, 'PNG', optimize=True)
    print(f"✅ Created: {output_path}")
    print(f"Final canvas size: {canvas_width}x{canvas_height}")
    print(f"Logo size on canvas: {new_width}x{new_height}")
    print(f"Padding: {x_offset}px on sides, {y_offset}px top/bottom")
    
except FileNotFoundError:
    print(f"❌ Error: Could not find {input_path}")
except Exception as e:
    print(f"❌ Error: {str(e)}")
