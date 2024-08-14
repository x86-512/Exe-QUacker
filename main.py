import qsharp
from sys import argv

def load_pe_sig(file:str) -> list[int]:
    with open(file, "rb") as pe:
        start:str = pe.read(2)
        return [int(start[0]),int(start[1])]

#Created on 7/21/2024
def main() -> None:
    if len(argv)<2:
        print(f"Invalid Arguments\nCorrect usage: python {__file__.split('/')[-1]} your_pe_file_here.exe")
        exit()
    print("This project is a proof-of-concept of using Grover's algorithm being used to decrypt a symmetrically encrypted PE file with a simple 8-bit xor encryption key")
    print("While the key could be figured out by simply xoring the plaintext and ciphertext, I wanted to test how a quantum computer would crack encryption\n")
    qsharp.init(project_root = "./")
    pe_enc_start:list[int] = load_pe_sig(argv[1])
    toCrack:int = pe_enc_start[0]
    toTest:int = pe_enc_start[1]
    if toCrack==77 and toTest==90: #It starts with MZ
        print("The PE file is unencrypted")
        exit()
    key_dec = int(qsharp.eval(f"pe_brute_forcer.CrackAsInt({toCrack})"))
    if toCrack^key_dec==77 and toTest^key_dec==90:
        print(f"[+] PE encryption successfully broken!\nXOR Key: {hex(key_dec)}")
    else:
        print("The encryption on this PE file is too strong... For now at least")

    #computer_guess = "left" if str(qsharp.eval("pe_brute_forcer.randomBit()"))=="One" else "right"

if __name__=="__main__":
    main()
