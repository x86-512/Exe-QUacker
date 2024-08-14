# Exe-Cracker-Quantum
A program that uses Grover's Algorithm with a simple phase oracle and Quantum superposition to crack an 8-bit encrypted exe file. This program is designed for quantum computers.

# The Math
Many algorithms, especially those in quantum computing, involve a lot of math. 

The first step is to calculate the number of optimal iterations for the main loop using the formula:
$N_i$ = $\frac{\pi}{4}\sqrt(\frac{N}{M}) - \frac{1}{2}$
N is the total number of possible items. M is the number of valid inputs.
After calculating the optimal number of iterations, the register will be initialized and put into superposition with the Hadamard Transform.

$H_n$|0$>^(\otimes n)$ = $\frac{1}{N} $$\left(\sum\limits_{x=0}^{N-1}(x)\right)$
The $\otimes n$ means that the transform is applied to n qubits.

Test:
\[ \sigma =\sqrt{\frac{1}{N}\sum\limits_{i=1}^N (x_i - \mu)} \]
