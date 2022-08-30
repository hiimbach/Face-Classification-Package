from mlchain.client import Client
import streamlit as st
import numpy as np 
from PIL import Image

model = Client(api_address='http://localhost:9998').model()

st.write("""
# Face Classification
""")

input_image = st.file_uploader('Upload a image you want to classify: ')
if input_image:
    img = Image.open(input_image)
    img = np.array(img)
    result = model.predict(img)
    st.write(f"""
    The class of the image is: {result}
    """)
