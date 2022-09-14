# Face Classification
This repository is my project in Techainer Bootcamp 2022. The purpose of this project is to understand and practice how to serve and package a model, with the application of Mlchain, Dvc, Docker, and Streamlit. 

## How to setup

Model weights can be download with: `pip install dvc && dvc pull`. Ask me if your google drive account does not have access to the weights folder yet

### Local development
- Make sure to have mamba installed
- To create a conda env for CPU only machine, run:
```bash
mamba env create -f environment_cpu.yaml
```
- For GPU env, run:
```bash
mamba env create -f environment_gpu.yaml
```
- Then you can activate it with: `mamba activate face_classification_edit_cpu` or `mamba activate face_classification_edit_cpu` accordingly.
### Docker
- To build the deployment docker image for CPU env, run:
```bash
DOCKER_BUILDKIT=1 docker build -f cpu.Dockerfile -t face_classification_cpu .
```
- For GPU env, run:
```bash
DOCKER_BUILDKIT=1 docker build -f gpu.Dockerfile -t face_classification_gpu .
```

## How to run

### Local development
Activate the conda env then simply run:
```bash
mlchain run
```
### Docker
- For CPU only env, run:
```bash
docker run --rm -it -p 9998:9998 face_classification_cpu
```
- For GPU env, please install `nvidia-docker`, then run:
```bash
docker run --gpus=all --rm -it -p 9998:9998 face_classification_gpu
```
Either case, an API server will be hosted at http://0.0.0.0:9998
### Streamlit
To run the streamlit:
```bash
streamlit run streamlit/web.py
```

## How to use
- To test the Python model, run: `python3 test.py`
- To test the Python client, run: `python3 client.py`
- To integrate this with your application, check out swagger interface at `/swagger` after you run the server.
- To use the streamlit, add the image sample.png from the folder sample_data, or use any image sized 128x128. 

---
If you have any question or encouter any problem regarding this repo. Please open an issue and cc me. Thank you.
