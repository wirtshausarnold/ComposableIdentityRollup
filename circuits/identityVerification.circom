pragma circom 2.0.0;

template IdentityVerification() {
    signal input identityHash; // Der Hash der Identität
    signal input proof; // Der Beweis, dass der Hash korrekt ist
    signal output isValid; // Output ob der Beweis gültig ist

    // Einfache Überprüfung: Ist der Beweis gleich dem erwarteten Wert?
    isValid <== proof == identityHash;
}

component main = IdentityVerification();
