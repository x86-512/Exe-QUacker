# Exe-Cracker-Quantum
A program that uses Grover's Algorithm with a simple phase oracle and Quantum superposition to crack an 8-bit encrypted exe file. This program is designed for quantum computers.

# The math behind the algorithm:
The number of iterations is calculated with the formula:

$N_i = \frac{\frac{\pi}{4}}{arcsin(\frac{1}{\sqrt(N)})-0.5}$ 

Where $N_i$ is the optimal number of iterations for the algorithm and N is the number of qubits that the key will be.

The key is then put into superposition with the Hadamard Transform:

$H|key\rangle^{\otimes n} = \frac{1}{\sqrt(N)}\[\sum_{x=0}^{N-1}|x\rangle \]$
