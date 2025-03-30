# Composable Consent Rollup

Composable Consent Rollup is a modular Zero-Knowledge-based proof system that allows anonymous opt-in/opt-out verification using Merkle membership and user consent signals. The circuit can be integrated into larger identity or access-control systems, enabling privacy-preserving consent flows.

## Features

- Merkle tree inclusion proof
- ZK-based user consent (opt-in/opt-out)
- Modular Circom circuit design
- Groth16 proof system via snarkjs
- Ready for Solidity Verifier export
- Clean structure for integration or hackathon submission

## Structure

ComposableConsentRollup/
│
├── circuits/                # Circom circuits (ConsentProof, MerkleMembership)
├── scripts/                 # JS scripts for setup, proof generation, verification
├── inputs_outputs/          # Example input files and outputs
├── trusted_setup/           # Powers of Tau files (.ptau)
├── js_witness_generators/   # Witness generation artifacts (ignored in repo)
├── test/                    # Placeholder for test cases (optional)
├── frontend/                # Placeholder for optional UI integration
└── README.md

## Quick Start

Install dependencies:
```bash
npm install
```

Compile circuit:
```bash
circom circuits/consentProof.circom --r1cs --wasm --sym -o circuits/
```

Trusted setup:
```bash
snarkjs powersoftau new bn128 14 pot14_0000.ptau
snarkjs powersoftau contribute pot14_0000.ptau pot14_final.ptau
snarkjs powersoftau prepare phase2 pot14_final.ptau pot14_prepared.ptau
snarkjs groth16 setup circuits/consentProof.r1cs pot14_prepared.ptau consentProof.zkey
```

Proof generation:
```bash
snarkjs wtns calculate circuits/consentProof_js/consentProof.wasm circuits/input/circuit_input_consentproof.json witness.wtns
snarkjs groth16 prove consentProof.zkey witness.wtns proof.json public.json
```

Verify proof:
```bash
snarkjs zkey export verificationkey consentProof.zkey verification_key.json
snarkjs groth16 verify verification_key.json public.json proof.json
```

## Git Push

When ready to submit:
```bash
git add .
git commit -m "Final submission: Composable Consent Rollup"
git push origin main
```

## License

MIT
