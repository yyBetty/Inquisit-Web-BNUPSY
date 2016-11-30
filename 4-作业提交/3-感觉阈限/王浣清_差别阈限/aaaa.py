#-*- coding: utf-8 -*-
from PIL import Image
from pylab import *

im = array(Image.open("C:/Users/air/OneDrive/Pictures/张翰.jpg").convert('L'))


work_dir = "C:/Users/air/OneDrive/Documents/实心实验/1125/王浣清_差别阈限/"

for i in range(0, 255, 15):
    image = (i/255)*im
    out = Image.fromarray(uint8(image))
    out.save(work_dir + "N" + str(i) + ".bmp")

