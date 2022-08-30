# The build-stage image:
FROM continuumio/miniconda3 AS build

# Install the package as normal:
COPY environment_gpu.yaml .
RUN conda env create -f environment_gpu.yaml

# Install conda-pack:
RUN conda install -c conda-forge conda-pack

# Use conda-pack to create a standalone environment
# in /venv:
RUN conda-pack -n face_classification_edit_gpu -o /tmp/env.tar && \
  mkdir /venv && cd /venv && tar xf /tmp/env.tar && \
  rm /tmp/env.tar

# We've put venv in same path it'll be in final image,
# so now fix up paths:
RUN /venv/bin/conda-unpack


# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster AS runtime

# Copy /venv from the previous stage:
# COPY --from=build /venv /venv

# Install common OS level dependencies
RUN apt-get update && \
    apt-get install -y rsync && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y

# Copy /venv from the previous stage
COPY --from=build /venv /venv

# Copy weights /code/weights
COPY weights /code/weights

# Then copy the rest of the code
RUN --mount=target=/ctx rsync -r --exclude='weights' /ctx/ /code/

WORKDIR /code/


# When image is run, run the code with the environment
# activated:
SHELL ["/bin/bash", "-c"]
ENTRYPOINT source /venv/bin/activate && cd /code/ && mlchain run