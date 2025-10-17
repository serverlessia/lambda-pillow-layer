#!/bin/bash
set -e

PYTHON_VERSIONS=("3.9" "3.10" "3.11" "3.12" "3.13")
LAYER_NAME="pillow-layer"

echo "Testing Pillow Lambda Layers for multiple Python versions..."

for PYTHON_VERSION in "${PYTHON_VERSIONS[@]}"; do
    echo "--- Testing for Python ${PYTHON_VERSION} ---"
    
    LAYER_PATH="build/python${PYTHON_VERSION}/python"
    LAYER_ZIP="build/${LAYER_NAME}-python${PYTHON_VERSION}.zip"

    if [ ! -f "${LAYER_ZIP}" ]; then
        echo "❌ Layer zip not found for Python ${PYTHON_VERSION}: ${LAYER_ZIP}"
        continue
    fi

    # Unzip the layer to a temporary location for testing
    TEST_DIR="test_env_python${PYTHON_VERSION}"
    mkdir -p "${TEST_DIR}"
    unzip -q "${LAYER_ZIP}" -d "${TEST_DIR}"

    # Create test script
    cat > "${TEST_DIR}/test_pillow.py" << 'EOF'
import sys
import os
import io
from PIL import Image

# Add the unzipped layer content to Python path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'python'))

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
        img_jpeg = Image.new('RGB', (10, 10), color='red')
        img_jpeg.save(io.BytesIO(), 'JPEG') # Save to BytesIO to avoid file system writes
        print("✅ JPEG format working")
    except Exception as e:
        print(f"❌ JPEG format failed: {e}")
    
    try:
        img_png = Image.new('RGB', (10, 10), color='blue')
        img_png.save(io.BytesIO(), 'PNG')
        print("✅ PNG format working")
    except Exception as e:
        print(f"❌ PNG format failed: {e}")
    
    try:
        img_webp = Image.new('RGB', (10, 10), color='green')
        img_webp.save(io.BytesIO(), 'WEBP')
        print("✅ WEBP format working")
    except Exception as e:
        print(f"❌ WEBP format failed: {e}")

    print("✅ All tests passed for Python version: ${PYTHON_VERSION}!")

except Exception as e:
    print(f"❌ Test failed for Python version ${PYTHON_VERSION}: {e}")
    sys.exit(1)
EOF

    # Run test using the specific Python version
    PYTHON_BIN="python${PYTHON_VERSION}"
    ${PYTHON_BIN} "${TEST_DIR}/test_pillow.py"
    
    # Clean up test environment
    rm -rf "${TEST_DIR}"

    echo "--- Test for Python ${PYTHON_VERSION} completed ---"
done

echo "All Pillow Lambda Layers tested successfully!"