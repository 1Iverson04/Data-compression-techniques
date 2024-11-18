<h3 style="text-align:center;">**DATA COMPRESSION TECHNIQUES** </h3>

Data compression, source coding, or bit-rate reduction refers to the practice of encoding information with fewer bits than the original representation. Any given compression is either lossy or lossless.\
**Lossless Compression Techniques**\
Lossless data compression algorithms use statistical redundancy to represent data without losing information. This process is reversible.\
The following are the primary lossless data compression techniques:

I. **Lempel-Ziv-Welch**

This is commonly used in GIF graphics, PKZIP programs, and modem hardware. LZW compression works by reading a sequence of symbols, arranging them into strings, and then converting the strings to codes.

II. **Huffman coding**

It is utilized as a component in lossless compressions like zip, gzip, and png, as well as lossy compression methods like mp3 and jpg.\
Huffman Coding represents each item of data with a variable length of bits, with shorter bits representing more often occurring data.\
Furthermore, it assures that no code is a prefix to another code, making compressed data easier to decipher.

III. **Run-length encoding (RLE)**

Run-length encoding compresses data by shrinking the physical size of a repeated string of characters. This procedure entails transforming the input data into a compressed format by finding and counting the consecutive occurrences of each character. The steps are as follows.

ü Traverse the input data.

ü Count the number of consecutive repeating characters (run length).

ü Store the character and its run length.

IV. **Arithmetic coding**

Arithmetic encoding is a method for encoding a sequence of symbols using a cumulative probability distribution, with each symbol represented by a binary fraction within a given range. It outperforms Huffman coding in terms of compression performance because it implements shift and add operations.
