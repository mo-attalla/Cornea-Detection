# Cornea Detection in Eye Images using MATLAB

## Overview
A MATLAB-based GUI application that detects the **cornea in digital eye images** using a custom algorithm that analyzes **color and shape features**, providing accurate localization and easy visualization.

## Features
- GUI interface with multiple display panels
- Real-time cornea detection using custom logic
- Scoring system based on circularity and position
- Morphological processing for noise removal

## How It Works
1. Convert image to double precision and separate RGB channels
2. Apply color thresholding to isolate red-dominant areas
3. Morphological operations (opening & closing) for mask refinement
4. Extract region properties (area, centroid, perimeter)
5. Score candidate regions by circularity and proximity to image center

## GUI Components
- 4 Axes: Original image, threshold mask, cleaned mask, final result
- Buttons: Load Image, Execute, Reset, Exit
- Status box: Displays current processing status

## Requirements
- MATLAB R2021a or higher
- Image Processing Toolbox

## License
This project is for academic and non-commercial use only.
