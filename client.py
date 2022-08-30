from mlchain.client import Client
from PIL import Image
import numpy as np 
from mlchain.workflows import Parallel, Task

model = Client(api_address='http://0.0.0.0:9999').model()

img = Image.open('sample_data/sample.png')
img = np.array(img)

result = model.predict(img)
print(result)