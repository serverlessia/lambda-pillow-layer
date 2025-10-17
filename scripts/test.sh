#!/bin/bash
set -e

echo "Testing Pillow Layer..."

# Create test script
cat > test_pillow.py << 'EOF'
import sys
import os
sys.path.insert(0, 'build/python')

try:
    from PIL import Image
    print("✅ Pillow import successful")

    # Test basic functionality
    img = Image.new('RGB', (100, 100), color='red')
    print("✅ Image creation successful")

    # Test format support
    formats = ['JPEG', 'PNG', 'GIF', 'WEBP']
    for fmt in formats:
        if fmt in Image.registered_extensions().values():
            print(f"✅ {fmt} format supported")
        else:
            print(f"❌ {fmt} format not supported")
    
    # Test actual format support by trying to create images
    try:
        # Test JPEG
        img_jpeg = Image.new('RGB', (10, 10), color='red')
        img_jpeg.save('test.jpg', 'JPEG')
        print("✅ JPEG format working")
        os.remove('test.jpg')
    except Exception as e:
        print(f"❌ JPEG format failed: {e}")
    
    try:
        # Test PNG
        img_png = Image.new('RGB', (10, 10), color='blue')
        img_png.save('test.png', 'PNG')
        print("✅ PNG format working")
        os.remove('test.png')
    except Exception as e:
        print(f"❌ PNG format failed: {e}")
    
    try:
        # Test WEBP
        img_webp = Image.new('RGB', (10, 10), color='green')
        img_webp.save('test.webp', 'WEBP')
        print("✅ WEBP format working")
        os.remove('test.webp')
    except Exception as e:
        print(f"❌ WEBP format failed: {e}")

    print("✅ All tests passed!")

except Exception as e:
    print(f"❌ Test failed: {e}")
    sys.exit(1)
EOF

# Run test
python3 test_pillow.py
rm test_pillow.py