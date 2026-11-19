# Assignment 6: Simple Cipher Decryption

## Problem Description
A simple cipher is built on an alphabet wheel that has uppercase English letters `['A' - 'Z']` written in clockwise order.

Given an encrypted string consisting of uppercase English letters `['A' - 'Z']` only, decrypt the string by replacing each character with the **$k^{\text{th}}$ character away on the wheel in the counter-clockwise direction**.

### Example
- **Encrypted string:** `'VTAOG'`
- **Shift ($k$):** `2`
- Moving counter-clockwise by 2:
  - `'V'` $\rightarrow$ `'T'`
  - `'T'` $\rightarrow$ `'R'`
  - `'A'` $\rightarrow$ `'Y'`
  - `'O'` $\rightarrow$ `'M'`
  - `'G'` $\rightarrow$ `'E'`
- **Decrypted result:** `'TRYME'`

## Mathematical Formula
For any uppercase letter $C$:
$$\text{Decrypted}(C) = \text{chr}\left(\left((\text{ord}(C) - \text{ord}('A') - (k \bmod 26)) \bmod 26\right) + \text{ord}('A')\right)$$

In Python, the modulo operator `%` naturally handles negative numbers correctly (e.g. `(-2) % 26 == 24`), making wrap-around from `'A'` to `'Z'` seamless.

## Validations Handled
- Type checking: verifies that `k` is an `int` and `encrypted` is a `str`.
- Value checking: verifies that all characters in `encrypted` belong to `['A'-'Z']`.
- Large $k$ handling: efficiently reduces shifts with `k % 26`.

## How to Run

```bash
python Automation/6.Simple_Cipher/Simple_Cipher.py
```

## Example Output
```text
TRYME
```
