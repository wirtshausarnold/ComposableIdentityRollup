pragma circom 2.1.4;

include "./lib/comparators.circom";
include "./lib/poseidon.circom";
include "./lib/merkleTreeInclusion.circom";
include "./merkleMembership.circom";
include "./lib/logic.circom";

template ConsentProof(depth) {
    signal input userChoice;
    signal input leaf;
    signal input root;
    signal input pathElements[depth];  
    signal input pathIndices[depth];   
    signal output isValid;

    component p = MerkleMembership(depth);
    p.leaf <== leaf;
    p.root <== root;

    // Loop through the path elements and indices
    for (var i = 0; i < depth; i++) {
        p.pathElements[i] <== pathElements[i];  
        p.pathIndices[i] <== pathIndices[i];    
    }

    component bothTrue = And();
    bothTrue.a <== p.isMember;
    bothTrue.b <== userChoice;

    isValid <== bothTrue.out;
}

component main = ConsentProof(20); 


