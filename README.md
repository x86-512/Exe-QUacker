# Exe-Cracker-Quantum
A program that uses Grover's Algorithm with a simple phase oracle and Quantum superposition to crack an 8-bit encrypted exe file. This program is designed for quantum computers.

# The math behind the algorithm:
The number of iterations is calculated with the formula:

$N_i = \frac{\frac{\pi}{4}}{arcsin(\frac{1}{\sqrt(n)})-0.5}$ 

Where $N_i$ is the optimal number of iterations for the algorithm and N is the number of qubits that the key will be.
The reason the formula is divided instead of multiplied is because the algorithm is less accurate when multiplied.

The key is then put into superposition with the Hadamard Transform:

$H|key\rangle^{\otimes n} = \frac{1}{\sqrt(N)}\sum_{x=0}^{N-1}|x\rangle $

n is the number if qubits and N is the total possible combinations of the key. $\otimes n$ means that the tensor product will be applied to n qubits in the key. In this case, the operation is applied to the whole key.

The oracle is applied, and the Hadamard gate is applied again, and a Conditional Z shift is applied.
The overall formula for the algorithm is
$(-H^{\otimes n}O_0H^{\otimes n}O_f)^{N_i}H^{\otimes n}$

Where $O_f$ is the oracle and $O_0$ is the conditional.

# How to run:
Install requirements: `pip install -r requirements.txt`
