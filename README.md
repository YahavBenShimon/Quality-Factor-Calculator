# Quality-Factor-Calculator

Analyze mechanical quality factors using ringdown and frequency response data.

## Overview

The provided MATLAB code allows users to:
- Load and preprocess data from text and CSV files.
- Analyze frequency response data and compute the mechanical quality factor.
- Analyze ringdown data, extract the envelope, and fit it to compute the mechanical quality factor.
- Display the resulting quality factors.


## Data File Format

1. **`Ring_Down.txt`**: 
    - This file should contain the ringdown data. 
    - Data format not specified, but assumed based on the `.data` accessor.
  
2. **`Frequency_Response.CSV`**: 
    - This file should contain the frequency response data.
    - Data format not specified, but assumed based on the `.data` accessor.

## Functions Overview

- **`ringdown_fitting(Ring_Down)`**: 
    - Takes in the ringdown data.
    - Computes the mechanical quality factor by fitting an exponential decay to the upper envelope of the data.

- **`frequency_response_analysis(Frequency_Response)`**: 
    - Analyzes the frequency response data.
    - Identifies the peak.
    - Fits a specified function to a subset of the data around the peak to compute the mechanical quality factor.

