from PIL import Image
from PIL import ImageDraw
work_dir = "C:/Users/16005/PycharmProjects/yuxian/"
sti_img = Image.open('BingWallpaper.jpg').convert('L')
draw = ImageDraw.Draw(sti_img)
for x in range(16):
     for i in range(0, list(sti_img.size)[0]):
            for j in range(0, list(sti_img.size)[1]):
                    color = sti_img.getpixel((i, j))
                    color += x
                    point = [i,j]
                    draw.point(point, color)
            if x == 0:
                pic_name = work_dir + "samepic" + str(x) + ".jpg"
            elif x % 2 != 0:
                pic_name = work_dir + "diffpic" + str(x) + ".jpg"
     sti_img.save(pic_name)
     #sti_img.show(pic_name)
sti_img = Image.open('BingWallpaper.jpg').convert('L')
draw = ImageDraw.Draw(sti_img)
for x in range(16):
     for i in range(0, list(sti_img.size)[0]):
            for j in range(0, list(sti_img.size)[1]):
                    color = sti_img.getpixel((i, j))
                    color -= x
                    point = [i,j]
                    draw.point(point, color)
            if x % 2 == 0:
                pic_name = work_dir + "diffpic" + str(x) + ".jpg"
     sti_img.save(pic_name)