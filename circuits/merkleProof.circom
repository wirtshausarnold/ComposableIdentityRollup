pragma circom 2.0.0;

include "circomlib/poseidon.circom";

template MerkleProof(depth) {
    signal input leaf;
    signal input root;
    signal input pathElements[depth];
    signal input pathIndices[depth];

    var hash = leaf;

    for (var i = 0; i < depth; i++) {
        component h = Poseidon(2);
        signal left;
        signal right;

        left <== pathIndices[i] === 0 ? hash : pathElements[i];
        right <== pathIndices[i] === 0 ? pathElements[i] : hash;

        h.inputs[0] <== left;
        h.inputs[1] <== right;

        hash <== h.out;
    }

    root === hash;
}

component main = MerkleProof(20);
