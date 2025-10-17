# Pillow Lambda Layer

[![CI](https://github.com/serverlessia/lambda-pillow-layer/actions/workflows/ci.yml/badge.svg)](https://github.com/serverlessia/lambda-pillow-layer/actions/workflows/ci.yml)
[![Python 3.9](https://img.shields.io/badge/python-3.9-blue.svg)](https://www.python.org/downloads/release/python-390/)
[![Python 3.10](https://img.shields.io/badge/python-3.10-blue.svg)](https://www.python.org/downloads/release/python-3100/)
[![Python 3.11](https://img.shields.io/badge/python-3.11-blue.svg)](https://www.python.org/downloads/release/python-3110/)
[![Python 3.12](https://img.shields.io/badge/python-3.12-blue.svg)](https://www.python.org/downloads/release/python-3120/)
[![Python 3.13](https://img.shields.io/badge/python-3.13-blue.svg)](https://www.python.org/downloads/release/python-3130/)

Production-ready Pillow layers for AWS Lambda supporting Python 3.9 through 3.13.

## 🚀 Quick Start

### Using Pre-built Layers

Download the latest layer for your Python version:

| Python Version | Download Link | Layer ARN |
|----------------|---------------|-----------|
| 3.9 | [Download](https://github.com/serverlessia/lambda-pillow-layer/releases/latest/download/python3.9-v1.zip) | `arn:aws:lambda:region:account:layer:pillow-python39:1` |
| 3.10 | [Download](https://github.com/serverlessia/lambda-pillow-layer/releases/latest/download/python3.10-v1.zip) | `arn:aws:lambda:region:account:layer:pillow-python310:1` |
| 3.11 | [Download](https://github.com/serverlessia/lambda-pillow-layer/releases/latest/download/python3.11-v1.zip) | `arn:aws:lambda:region:account:layer:pillow-python311:1` |
| 3.12 | [Download](https://github.com/serverlessia/lambda-pillow-layer/releases/latest/download/python3.12-v1.zip) | `arn:aws:lambda:region:account:layer:pillow-python312:1` |
| 3.13 | [Download](https://github.com/serverlessia/lambda-pillow-layer/releases/latest/download/python3.13-v1.zip) | `arn:aws:lambda:region:account:layer:pillow-python313:1` |

### Upload to AWS Lambda

```bash
# Upload layer to AWS Lambda
aws lambda publish-layer-version \
  --layer-name pillow-python313 \
  --description "Pillow layer for Python 3.13" \
  --zip-file fileb://python3.13-v1.zip \
  --compatible-runtimes python3.13 \
  --compatible-architectures x86_64
```

### Use in Your Lambda Function

```python
import json
from PIL import Image
import io

def lambda_handler(event, context):
    # Pillow is now available!
    try:
        # Process image from S3
        if 'Records' in event:
            bucket = event['Records'][0]['s3']['bucket']['name']
            key = event['Records'][0]['s3']['object']['key']
            
            # Your image processing code here
            img = Image.new('RGB', (100, 100), color='red')
            
            return {
                'statusCode': 200,
                'body': json.dumps('Image processed successfully!')
            }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error: {str(e)}')
        }
```

## 📦 Layer Details

| Feature | Value |
|---------|-------|
| **Pillow Version** | 10.4.0 |
| **Layer Size** | ~3.6MB (compressed) |
| **Architecture** | x86_64 |
| **Supported Formats** | JPEG, PNG, GIF, WEBP |
| **Python Versions** | 3.9, 3.10, 3.11, 3.12, 3.13 |
| **Memory Usage** | ~171MB (uncompressed) |

## 🛠 Building from Source

### Prerequisites

- Python 3.9+ installed
- System dependencies for Pillow compilation

### Build All Versions

```bash
# Clone the repository
git clone https://github.com/serverlessia/lambda-pillow-layer.git
cd lambda-pillow-layer

# Build layers for all Python versions
cd aws-lambda-pillow-layer
./scripts/build-multi-version.sh

# Test all layers
./scripts/test-multi-version.sh
```

### Build Single Version

```bash
# Build for specific Python version (defaults to 3.13)
./scripts/build.sh
```

### DevContainer

Open in VS Code DevContainer for automatic multi-version building and testing:

1. Open project in VS Code
2. Use "Reopen in Container" command
3. Layers will be built and tested automatically

## 📊 Performance

- **Image Creation**: 4 images in 0.01s
- **Image Processing**: 4 images in 0.15s
- **Format Conversion**: 3 images to 3 formats in 0.15s
- **Memory Cleanup**: Excellent (0MB increase)
- **Large Images**: 4000x4000 processed in 0.38s

## 🚦 Status

| Component | Status | Notes |
|-----------|--------|-------|
| **Python 3.9** | ✅ Working | Full Pillow support |
| **Python 3.10** | ✅ Working | Full Pillow support |
| **Python 3.11** | ✅ Working | Full Pillow support |
| **Python 3.12** | ✅ Working | Full Pillow support |
| **Python 3.13** | ✅ Working | Full Pillow support |
| **CI/CD** | ✅ Active | Automated builds and releases |
| **DevContainer** | ✅ Ready | Multi-version support |

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `./scripts/test-multi-version.sh`
5. Submit a pull request

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/serverlessia/lambda-pillow-layer/issues)
- **Discussions**: [GitHub Discussions](https://github.com/serverlessia/lambda-pillow-layer/discussions)
- **Documentation**: [Wiki](https://github.com/serverlessia/lambda-pillow-layer/wiki)
