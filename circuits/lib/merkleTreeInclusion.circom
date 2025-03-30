pragma circom 2.1.4;

include "poseidon.circom";



template MerkleTreeInclusionProof(depth) {
    signal input leaf;
    signal input path_elements[depth];
    signal input path_indices[depth];
    signal output root;

    signal current[depth + 1];
    current[0] <== leaf;

    component hashers[depth];

signal left[depth];
signal right[depth];

for (var i = 0; i < depth; i++) {
    hashers[i] = HashLeftRight();

    left[i] <== path_indices[i] * path_elements[i] + (1 - path_indices[i]) * current[i];
    right[i] <== (1 - path_indices[i]) * path_elements[i] + path_indices[i] * current[i];

    hashers[i].left <== left[i];
    hashers[i].right <== right[i];

    current[i + 1] <== hashers[i].hash;
}


    root <== current[depth];
}
