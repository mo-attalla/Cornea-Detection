# 🎯 High-Precision Face Detection using MATLAB GUI

## 📌 Overview

This project presents a **face detection system** developed in MATLAB as part of the *Image Processing (ECE228)* course at Zagazig University. The system is capable of accurately detecting **human faces** in digital images by leveraging a **custom-designed algorithm** that avoids the use of high-level built-in face detection functions.

Instead, we focused on implementing fundamental image processing techniques such as **skin tone segmentation**, **symmetry analysis**, and **geometric filtering** to detect facial regions. The project also includes a full **Graphical User Interface (GUI)** to allow users to interactively load images, start detection, and view results.

---

## 🎯 Objectives

- Develop a face detection system from scratch using basic image processing techniques.
- Avoid the use of built-in high-level detectors (like `vision.CascadeObjectDetector`).
- Build a GUI to support non-technical users in running detection easily.
- Ensure accurate detection under different lighting conditions and backgrounds.

---

## 🛠️ How It Works

The system pipeline consists of the following main stages:

1. **Image Preprocessing**
   - Apply Gaussian filter to reduce noise.
   - Convert the RGB image to **YCbCr color space** to better separate skin tones.

2. **Skin Detection**
   - Threshold the Cr and Cb channels to isolate potential skin regions.
   - Generate a binary skin mask.

3. **Morphological Processing**
   - Clean up the binary mask using morphological operations:
     - `imfill` to fill holes
     - `bwareaopen` to remove small objects

4. **Region Analysis**
   - Extract connected components using `regionprops`.
   - Measure area, eccentricity, and bounding boxes.

5. **Face Verification**
   - Verify potential face regions using:
     - **Elliptical shape matching**
     - **Horizontal symmetry** (left/right pixel similarity)
     - **Eccentricity constraint** to rule out elongated regions

---

## 🖥️ GUI Features

- `Load Image`: Import an image from the local machine.
- `Start Detection`: Run the detection pipeline and draw bounding boxes around detected faces.
- `Reset`: Clear the interface for a new image.
- `Exit`: Close the application.

---

## ✅ Results & Performance

- **Accuracy**: High for well-lit, frontal face images.
- **False Positives**: Very low due to strict shape and symmetry checks.
- **Speed**: Acceptable for real-time use within the GUI.
- **Robustness**: Performs well with variations in skin tone and lighting.

---

## ⚙️ Requirements

- MATLAB R2021a or newer
- Image Processing Toolbox



## 📃 License

This project was developed for academic purposes and is open for educational use.  
Not intended for commercial applications.

---

## 📂 Repository Structure

