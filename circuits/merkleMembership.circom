pragma circom 2.1.4;

include "./lib/comparators.circom";
include "./lib/poseidon.circom";
include "./lib/incrementalMerkleTree.circom";

template MerkleMembership(depth) {
    signal input leaf;
    signal input root;
    signal input pathElements[depth];
    signal input pathIndices[depth];
    signal output isMember;

    component p = IncrementalMerkleTree(depth);
    for (var i = 0; i < depth; i++) {
        p.path_elements[i] <== pathElements[i];
        p.path_indices[i] <== pathIndices[i];

    }

    p.leaf <== leaf;

    component eq = IsEqual();
    eq.in[0] <== p.root;
    eq.in[1] <== root;

    isMember <== eq.out;
}

component main = MerkleMembership(20);
