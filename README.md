# Composable Consent Rollup

Composable Consent Rollup is a minimal zero-knowledge module that allows anonymous, verifiable consent logic (opt-in / opt-out) using Circom, SnarkJS and Poseidon-based Merkle trees.

The project was submitted to the Espresso x DoraHacks Hackathon in the “Build Something Real” category. It focuses on privacy, composability and real-world applicability within decentralized identity systems.

## What It Does

- Implements a Merkle membership proof using Poseidon hash and incremental tree logic.
- Uses Groth16 to prove Merkle inclusion without revealing the leaf.
- Includes a Solidity verifier contract to validate the proof on-chain.
- Designed for integration into modular identity stacks and privacy-preserving systems.

## Technical Overview

- Circuit: `merkleMembership.circom`
- Setup: ptau 14 (`pot14_final.ptau`)
- Proof system: Groth16
- Verifier: generated via SnarkJS and ready for on-chain deployment

## Proof Artifacts

- `input.json` – minimal dummy input for testing (leaf, path, root)
- `witness.wtns` – generated witness for the proof
- `merkleMembership.zkey` – proving key
- `proof.json` – final zk-proof
- `public.json` – corresponding public inputs

## Notes

The full zk-proof process was completed shortly before submission. Due to a last-minute mismatch between circuit and proving key, earlier attempts failed silently or with inconsistent witness lengths. These were resolved by rebuilding the entire flow using the correct ptau and consistent input structure.

A demo video was planned but not completed in time. All proof components and circuit logic are verifiable and functional.

## Repository Structure

