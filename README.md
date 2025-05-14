# 👁️ Cornea Detection in Eye Images using MATLAB GUI

## 📌 Overview

This project presents a **cornea detection system** developed in MATLAB for use in analyzing digital eye images. It was completed as part of the *Image Processing (ECE228)* course at Zagazig University.

The goal is to accurately identify and highlight the **corneal region** in frontal eye images using a **custom image processing algorithm**. The system avoids deep learning or built-in vision libraries, relying instead on **color thresholding**, **morphological operations**, and **region analysis**. A **graphical user interface (GUI)** was also built to support loading images, running detection, and viewing results in real-time.

---

## 🎯 Objectives

- Detect the cornea based on color and shape features.
- Build a user-friendly desktop GUI in MATLAB.
- Ensure robustness across varying lighting conditions and eye types.
- Maintain a lightweight system with fast execution.

---

## 🛠️ How It Works

### 1. **Preprocessing & Color Filtering**
- Convert RGB image to double precision.
- Split into R, G, and B channels.
- Apply custom thresholding to isolate red-dominant regions resembling corneal reflections.

### 2. **Binary Mask Generation**
- Generate a binary mask where the pixel intensity matches expected corneal appearance.
- Apply **morphological opening and closing** to clean up noise.

### 3. **Region Extraction & Scoring**
- Label connected components.
- Extract region properties: area, centroid, circularity.
- Use a **scoring system** based on proximity to the image center and how circular the region is.

### 4. **Final Visualization**
- Draw circles around the detected cornea using `viscircles` for clarity.

---

## 🖥️ GUI Features

- `Load Image`: Load any digital eye image.
- `Execute`: Run the cornea detection algorithm.
- `Reset`: Clear all outputs.
- `Exit`: Close the app.
- Status box: Displays processing state like "Ready", "Processing", or "Done".

Four display panels show:
- Original image  
- Color threshold mask  
- Cleaned mask  
- Final detection result  

---

## ✅ Results & Performance

- **Accuracy**: High for clear, frontal eye images.
- **False Detection Rate**: Low due to region scoring filters.
- **Speed**: Near real-time processing.

---

## ⚙️ Requirements

- MATLAB R2021a or higher
- Image Processing Toolbox


## 📃 License

For academic use only. Developed as a course project.

