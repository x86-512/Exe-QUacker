namespace pe_brute_forcer {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;
    
    //Grover's Algorithm explaination
    //In order to find the correct decryption key for the PE, we need to do the folowing:
    //1: The key is 8 bits(I might expand it to 16), so there are 2^8 or 2^16 possible combinations for the key
    //2: Put each qubit for the key into uniform superposition
    //3: The oracle function xors the plaintext and applies a Pauli-X on the quantum state that xors to M
    //4: Grover's Diffusion operator is applied until there is a high probability of the wavefunction measuring to the correct value
    //For more information: See: https://learn.microsoft.com/en-us/azure/quantum/concepts-grovers
    //This thing has pretty good time complexity too, which is nice

    operation Oracle(key: Qubit[], register: Qubit[],  target: Qubit, ciphertext : Int) : Unit is Adj{
        //Target 1, M(for reference): 01001101
        
        //This operation is unitary, so it can preserve the total probability of measurement for the quantum state
        within {
            //Key is in superposition, 
            ApplyXorInPlace(ciphertext, key); //This is little endian BTW
        } apply {
            ApplyControlledOnInt(77, X, key, target);//M is 77 in dec
        }
        //Target 2, Z(for reference): 1011010
    }

    //Okay, when there are no quantum operations, Q# wants it to be a function
    function CalculateIterations(num_qubits : Int) : Int {
        return Round((PI()/4.0)/(ArcSin(1.0 / Sqrt(IntAsDouble(1<<<num_qubits))))-0.5); //Calculates N Optimal
    } //Actually works better when it is divided. I know this is against the algorithm, but it works better when I divide pi/4 by the arcsin

    operation ApplyOracle(oracle : ((Qubit[], Qubit[], Qubit) => Unit is Adj), qubits : Qubit[], register : Qubit[]) : Unit {
        use target = Qubit();
        X(target);
        H(target);//Initializes to - 1/sqrt(2)|1> to cause phase kickback 
        oracle(qubits, register, target); //Causes phase kickback on the correct key state
        H(target);
        X(target); 
        Reset(target); //Quantum operations must be reversable, so the last H,X, and reset make it reversable, also no unreset qubits
    }

    operation Crack(ciphertext : Int) : Result[] {
        let numOfQubits = 8;
        use qubits = Qubit[numOfQubits];
        let numOfIterations = CalculateIterations(numOfQubits);
        use register = Qubit[8];
        let oracle = Oracle(_, _, _, ciphertext);//All of the parameters will be assumed to be empty except for ciphertext
        
        
        ApplyToEach(H, qubits);
        //Grover's Diffusion Operator (with the Oracle)
        //Technically Grover's Algorithm uses the H gate for constructive interference to amplify the correct state
        for  _ in 1..numOfIterations {
            
            ApplyOracle(oracle, qubits, register); //The correct one is now - due to phase kickback

            ApplyToEach(H, qubits); //If the ones count for the state is even, the +- state is not flipped
            ApplyToEach(X, qubits); //Flips the - phase on everything in the state except 0
            Controlled Z(Most(qubits), Tail(qubits));//Conditional Phase Shift here
            ApplyToEach(X, qubits); //Reverts back to the original state so the function is reversable
            ApplyToEach(H, qubits); //Amplifies the correct probability until it is 1
        }

        
        ResetAll(register);
        return MResetEachZ(qubits);
    }

    operation CrackAsInt(ciphertext : Int) : Int {
        let result = Crack(ciphertext);
        let result_flipped : Bool[] = ResultArrayAsBoolArray(result);
        let cracked_key : Int = BoolArrayAsInt(result_flipped); //Little Endian
        return cracked_key;
    }

    @EntryPoint()
    operation HelloQ() : Unit {
        Message($"Key: {CrackAsInt(56)}"); //Test
    }

}



