const snarkjs = require("snarkjs");
const fs = require("fs");

async function verify() {
    // Lade den Setup-Parameter
    const setup = JSON.parse(fs.readFileSync("setup_params.json"));
    
    // Lade den Beweis
    const proof = JSON.parse(fs.readFileSync("proof.json"));
    
    // Verifiziere den Beweis
    const result = await snarkjs.verify(setup, proof);
    console.log("Proof verification result: ", result);
}

verify();
