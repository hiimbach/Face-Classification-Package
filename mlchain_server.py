# Import mlchain 
from mlchain.base import ServeModel
from mlchain import mlconfig 


# IMPORT YOUR CLASS HERE - YOU ONLY CARE THIS
from infer import Face_Classification_Model # Import your class here 

model = Face_Classification_Model(weight_path=mlconfig.weight_path) # Init your class first 
# END YOUR WORK HERE


# Wrap your class by mlchain ServeModel
serve_model = ServeModel(model)

# THEN GO TO CONSOLE: 
# mlchain run -c mlconfig.yaml 