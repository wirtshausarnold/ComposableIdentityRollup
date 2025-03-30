const { IncrementalMerkleTree } = require("@zk-kit/incremental-merkle-tree");
const circomlib = require("circomlibjs");
const fs = require("fs");

async function run() {
  const poseidon = await circomlib.buildPoseidon();
  const hashFunction = (inputs) => poseidon.F.toString(poseidon(inputs));

  const tree = new IncrementalMerkleTree(
    hashFunction,
    20,   // Merkle tree depth
    "0",  // Zero value as string
    2     // Binary tree
  );

  const leaf1 = "123456789";
  const leaf2 = "987654321";
  const leaf3 = "555555555";

  tree.insert(leaf1);
  tree.insert(leaf2);
  tree.insert(leaf3);

  const proof = tree.createProof(1); // Proof for second leaf
  const isValid = verifyMerkleProof(hashFunction, proof, 2);

  console.log("Merkle Root:", tree.root);
  console.log("Verifying proof for leaf2...");
  console.log("Is valid?", isValid);

  fs.writeFileSync(
    "proof.json",
    JSON.stringify({
      leaf: proof.leaf,
      root: proof.root,
      pathIndices: proof.pathIndices,
      siblings: proof.siblings
    }, null, 2)
  );

  fs.writeFileSync(
    "circuit_input.json",
    JSON.stringify({
      leaf: proof.leaf,
      root: proof.root,
      pathElements: proof.siblings.flat(),
      pathIndices: proof.pathIndices
    }, null, 2)
  );
}

function verifyMerkleProof(hashFn, proof, arity) {
  let computed = proof.leaf;

  for (let i = 0; i < proof.siblings.length; i++) {
    const siblings = proof.siblings[i];
    const slot = proof.pathIndices[i];

    const elements = [...siblings];
    elements.splice(slot, 0, computed);

    computed = hashFn(elements.map(BigInt));
  }

  return computed === proof.root;
}

run();
