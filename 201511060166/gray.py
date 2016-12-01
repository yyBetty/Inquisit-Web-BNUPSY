from PIL import Image
import os
workdir ="Users/BrendadaLi/PycharmProjects/1130"
os.chdir(workdir)
im = Image.open(workdir+'kirk.jpg').convert('L')
# im.save('graypic1.jpg')
from PIL import ImageDraw
draw = ImageDraw.Draw(im)  for x in range(1, 11):
for i in range(0, list(im.size)[0]):
for j in range(0, list(im.size)[1]):
color = im.getpixel((i, j))
# 改变灰度值
color = color + x
point = [i, j]
draw.point(point, color)
# im.show('pic1.jpg')
im.save('graykirk'+str(x-1)+'.jpg')
PicNames = os.listdir(workdir + "graykirk\\")
# 打印
print("<item gray>")
for i in range(0, len(PicNames)):
j = i + 1
print('    ' + '/' + str(j) + ' = ' + '"' + PicNames[i] + '"')
print("</item>")
print("\n")
