// scripts/generateProof.js

const snarkjs = require("snarkjs");
const fs = require("fs");

async function main() {
    const input = JSON.parse(fs.readFileSync("circuit_input.json", "utf-8"));

    const { proof, publicSignals } = await snarkjs.groth16.fullProve(
        input,
        "circuits/merkleMembership_js/merkleMembership.wasm",
        "circuits/merkleMembership.zkey"
    );

    fs.writeFileSync("proof.json", JSON.stringify(proof, null, 2));
    fs.writeFileSync("public.json", JSON.stringify(publicSignals, null, 2));

    const res = await snarkjs.groth16.verify(
        JSON.parse(fs.readFileSync("circuits/verification_key.json")),
        publicSignals,
        proof
    );

    console.log("Proof is valid:", res);
}

main().catch((err) => {
    console.error("Error:", err);
});
