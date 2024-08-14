# Exe-Cracker-Quantum
A program that uses Grover's Algorithm with a simple phase oracle and Quantum superposition to crack an 8-bit encrypted exe file. This program is designed for quantum computers.

# The math behind the algorithm:
The number of iterations is calculated with the formula:
$N_i = \frac{\frac{\pi}{4}}{arcsin(\frac{1}{\sqrt(N)})-0.5}$
$N_i$ is the optimal number of iterations for the algorithm. N is the number of qubits that the key will be.
