# -*- coding: utf-8 -*-
"""
Created on Wed Oct 24 16:41:54 2018

@author: Rhiannon
"""

import numpy as np
from PIL import Image
import matplotlib
import glob
import pandas
import re

#create empty dict to store results
images_df = []
#iterate over the images
#make sure your folder is called images and is in your main dir
for filepath in glob.iglob("images/*.jpg"):
    img = Image.open(filepath)
    #img in jpg works best just dont use format with transparency 
    arr = np.array(img)
    #print(arr)
    #arr = arr[:,:, :3] this was for RGBA to a len 3 array conversion to rem A
    arr = matplotlib.colors.rgb_to_hsv(arr) #conv to hsv
    
    #initiatlise pixel count
    n = 0 
    
    for row in range(0, len(arr)):
        for col in range(0, len(arr[row])):
            #blue is 114 to 178 hue value
            if arr[row][col][0] <178/255 and arr[row][col][0] > 114/255:
                #hsv values as percentage of 255
                n = n + 1
            
    #calculate percentage cover of blue
    size = arr.shape
    total_pixels = size[0] * size[1]
    perc_blue = (n/total_pixels)*100
    print(perc_blue)
    file_split = re.split(r"\\", filepath)
    jpg_split = re.split(".jpg", file_split[1])
    name_split = re.split("_", jpg_split[0])
    images_df.append([name_split[0], name_split[1], perc_blue])
    
print(images_df)
    
