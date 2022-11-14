from PIL import Image

frames = []

for i in range(2, 200):
    new_frame = Image.open(f"animation_{i}.png")
    frames.append(new_frame)
    
frames[0].save("Animation_vel.gif", 'GIF', append_images=frames[1:], save_all=True, duration=20, loop=0)