
def duplicate_items(listA: list, listB: list) -> list:
    # Check empty list
    if not listA or not listB:
        return []

    # Select smaller list for iteration
    if len(listA) <= len(listB):
        samples, checker = listA, listB
    else:
        samples, checker = listB, listA

    # Convert checker to set for fast lookup
    checker = set(checker)

    # Find duplicates without repeating values
    result = list(dict.fromkeys(
        x for x in samples if x in checker
    ))

    return result


if __name__ == '__main__':
    a = [1, 2, 3, 5, 6, 8, 9]
    b = [3, 2, 1, 5, 6, 0]

    print("Answer:", duplicate_items(a, b))
