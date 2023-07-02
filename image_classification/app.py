import torch
from torchvision import models, transforms
from PIL import Image
from flask import Flask, request, jsonify
from werkzeug.exceptions import BadRequest
import logging
import io

# Set up logging
logging.basicConfig(level=logging.INFO)

# Load the pre-trained VGG19 model
model = models.vgg19(pretrained=True)
model.eval()

# Define the image transformations
transform = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])

# Create a Flask app
app = Flask(__name__)

@app.route('/classify', methods=['POST'])
def classify():
    try:
        # Check if an image was posted
        if 'image' not in request.files:
            raise BadRequest('Missing image file')

        # Load the image
        image_file = request.files['image']
        image = Image.open(io.BytesIO(image_file.read())).convert('RGB')

        # Apply the transformations and add a batch dimension
        input_tensor = transform(image).unsqueeze(0)

        # Use the model to classify the image
        with torch.no_grad():
            output = model(input_tensor)

        # Get the predicted class
        _, predicted_class = torch.max(output, 1)

        # Return the classification result
        return jsonify({'class': int(predicted_class)})

    except BadRequest as e:
        logging.error(e)
        return jsonify({'error': str(e)}), 400

    except Exception as e:
        logging.error(e)
        return jsonify({'error': 'An unexpected error occurred.'}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)