# -*- coding: utf-8 -*-
"""
Created on Wed Oct 24 16:41:54 2018

@author: Rhiannon
"""

import numpy as np
from PIL import Image
import matplotlib

img = Image.open("pics/roots1jpg.jpg")
#img in jpg works best just dont use format with transparency 
arr = np.array(img)
print(arr)
#arr = arr[:,:, :3] this was for RGBA to a len 3 array conversion to rem A
arr = matplotlib.colors.rgb_to_hsv(arr) #conv to hsv

n = 0 

for row in range(0, len(arr)):
    for col in range(0, len(arr[row])):
        #blue is 114 to 178
        if arr[row][col][0] <178/255 and arr[row][col][0] > 114/255:
            #hsv values as percentage
            n = n + 1
        
print(n)


    
