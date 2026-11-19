# Assignment 1: Check Duplicate Items

## Problem Description
Write a function in your preferred programming language to check duplicate items from `List A` and `List B` and append them to a new list.

**Given Input:**
- List A : `[1, 2, 3, 5, 6, 8, 9]`
- List B : `[3, 2, 1, 5, 6, 0]`

**Expected Result:**
- `[1, 2, 3, 5, 6]` (preserving the order from List A without duplicate entries)

## Implementation Details
The solution is implemented in Python (`check_duplicate.py`).
- **Optimization:** Converts the checker list into a hash set (`O(1)` average lookup time) and iterates over the smaller list.
- **Order Preservation & Uniqueness:** Uses `dict.fromkeys()` to maintain insertion order while filtering out duplicates.
- **Time Complexity:** `O(N + M)`
- **Space Complexity:** `O(N + M)`

## How to Run

```bash
python Automation/1.Check_Duplicate/check_duplicate.py
```

## Example Output
```text
Answer: [1, 2, 3, 5, 6]
```
