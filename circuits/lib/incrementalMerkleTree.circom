pragma circom 2.1.4;

include "poseidon.circom";

template HashLeftRight() {
    signal input left;
    signal input right;
    signal output hash;

    component hasher = Poseidon(2);
    hasher.inputs[0] <== left;
    hasher.inputs[1] <== right;
    hash <== hasher.out;
}

template IncrementalMerkleTree(depth) {
    signal input leaf;
    signal input path_elements[depth];
    signal input path_indices[depth];
    signal output root;

    signal current[depth + 1];
    signal left[depth];
    signal right[depth];
    signal tmp1[depth];
    signal tmp2[depth];
    signal tmp3[depth];
    signal tmp4[depth];

    component h[depth];

    current[0] <== leaf;

    for (var i = 0; i < depth; i++) {
        h[i] = HashLeftRight();

        // LEFT: (path_indices * path_elements) + ((1 - path_indices) * current)
        tmp1[i] <== path_indices[i] * path_elements[i];
        tmp2[i] <== (1 - path_indices[i]) * current[i];
        left[i] <== tmp1[i] + tmp2[i];

        // RIGHT: (1 - path_indices) * path_elements + path_indices * current
        tmp3[i] <== (1 - path_indices[i]) * path_elements[i];
        tmp4[i] <== path_indices[i] * current[i];
        right[i] <== tmp3[i] + tmp4[i];

        h[i].left <== left[i];
        h[i].right <== right[i];

        current[i + 1] <== h[i].hash;
    }

    root <== current[depth];
}
