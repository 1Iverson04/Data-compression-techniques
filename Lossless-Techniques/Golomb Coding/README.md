# Golomb Coding in MATLAB

[![MATLAB](https://img.shields.io/badge/MATLAB-R2021a-blue)](https://www.mathworks.com/products/matlab.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A MATLAB implementation of Golomb Coding for lossless compression of **numerical data** and **strings**, with interactive Live Script demonstrations.

---

## Features
- **Numerical Data Compression**: 
  - `golomb_encode.m`: Encodes integer arrays
  - `golomb_decode.m`: Decodes Golomb-compressed data
- **String Compression**:
  - `golomb_encode_string.m`: Encodes ASCII strings
  - `golomb_decode_string.m`: Decodes strings
- **Interactive Demos**:
  - `golomb_working.mlx`: Live Script for numerical data (code + outputs)
  - `GolombStringWorking.mlx`: Live Script for string compression
  - PDF versions of Live Scripts for quick reference

---

## Files
### Numerical Data Compression
| File                     | Description                                |
|--------------------------|--------------------------------------------|
| `golomb_encode.m`        | Encodes integer arrays                     |
| `golomb_decode.m`        | Decodes numerical data                     |
| `golomb_working.mlx`     | Live Script Demo (Code + Outputs)          |
| `golomb_working.pdf`     | Pre-rendered Live Script Outputs           |

### String Compression
| File                     | Description                                |
|--------------------------|--------------------------------------------|
| `golomb_encode_string.m` | Encodes ASCII strings                      |
| `golomb_decode_string.m` | Decodes compressed strings                 |
| `GolombStringWorking.mlx`| Live Script for string compression         |
| `GolombStringWorking.pdf`| Pre-rendered Live Script Outputs           |

---

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/1Iverson04/Data-compression-techniques.git
