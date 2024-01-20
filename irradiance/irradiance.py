import cv2
import numpy as np
import os
import matplotlib.pyplot as plt

os.environ["OPENCV_IO_ENABLE_OPENEXR"] = '1'

exr_image = cv2.imread('irradiance_b.exr', cv2.IMREAD_ANYCOLOR | cv2.IMREAD_ANYDEPTH)
exr_image = np.array(exr_image)

brightness = 0.2126 * exr_image[..., 0] + 0.7152 * exr_image[..., 1] + 0.0722 * exr_image[..., 2]
plt.imshow(brightness, cmap='jet', interpolation='nearest', vmin=0, vmax=30)
plt.axis('off')
plt.colorbar()
plt.savefig('heatmap.png', bbox_inches='tight', pad_inches=0)
plt.show()