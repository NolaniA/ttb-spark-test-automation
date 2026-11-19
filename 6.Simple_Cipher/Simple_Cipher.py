def simple_cipher(encrypted: str, k: int) -> str:
    if not isinstance(k, int):
        raise TypeError("k must be an integer")

    if not isinstance(encrypted, str):
        raise TypeError("encrypted must be string")

    if not all("A" <= char <= "Z" for char in encrypted):
        raise ValueError("encrypted must contain only uppercase A-Z characters")

    shift = k % 26
    return "".join(chr((ord(char) - ord("A") - shift) % 26 + ord("A")) for char in encrypted)


if __name__ == '__main__':
    encrypted = 'VTAOG'
    k = 2
    print(simple_cipher(encrypted, k))