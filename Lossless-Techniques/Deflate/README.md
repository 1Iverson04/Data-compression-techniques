# DEFLATE Compression in MATLAB

[![MATLAB](https://img.shields.io/badge/MATLAB-R2020b%2B-blue)](https://www.mathworks.com/products/matlab.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A MATLAB implementation of the DEFLATE algorithm (LZ77 + Huffman Coding) for lossless compression, part of the [Data Compression Techniques](https://github.com/1Iverson04/Data-compression-techniques) repository.

---

## Features
- **LZ77 Encoding/Decoding** with sliding window
- **Huffman Tree Construction** with frequency analysis
- **Compression Ratio Metrics**
- Interactive Live Script Demo (`deflate_working.mlx`)

---

## Files
| File                     | Description                                |
|--------------------------|--------------------------------------------|
| `deflate_encode.m`       | DEFLATE Encoder (LZ77 + Huffman)           |
| `deflate_decode.m`       | DEFLATE Decoder                            |
| `HuffmanNode.m`          | Huffman Tree Node Class                    |
| `match_length.m`         | Helper for LZ77 match length calculation   |
| `deflate_working.mlx`    | Live Script Demo with Visualizations       |

---

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/1Iverson04/Data-compression-techniques.git
