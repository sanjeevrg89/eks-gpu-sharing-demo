# Use an official PyTorch runtime as a build image
FROM pytorch/pytorch:latest as build

# Set the working directory in the build image to /app
WORKDIR /app

# Copy the current directory contents into the build image at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Use a smaller base image for the final image
FROM python:3.8-slim as final

# Copy the /app directory from the build image to the final image
COPY --from=build /app /app

# Set the working directory in the final image to /app
WORKDIR /app

# Make port 80 available to the world outside this container
EXPOSE 80

# Run app.py when the container launches
CMD ["python", "app.py"]