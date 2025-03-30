const snarkjs = require("snarkjs");
const fs = require("fs");

async function setup() {
    // Lade das Circuit
    const circuit = await snarkjs.circom("circuits/identityVerification.circom");
    
    // Erstelle die Setup-Parameter
    const setup = await snarkjs.setup(circuit);
    
    // Speichern der Setup-Parameter in einer Datei
    fs.writeFileSync("setup_params.json", JSON.stringify(setup));
    
    console.log("Setup completed!");
}

setup();
