const ImportAs2805KeyCryptogram = @import("import_as_2805_key_cryptogram.zig").ImportAs2805KeyCryptogram;
const ImportDiffieHellmanTr31KeyBlock = @import("import_diffie_hellman_tr_31_key_block.zig").ImportDiffieHellmanTr31KeyBlock;
const ImportKeyCryptogram = @import("import_key_cryptogram.zig").ImportKeyCryptogram;
const RootCertificatePublicKey = @import("root_certificate_public_key.zig").RootCertificatePublicKey;
const ImportTr31KeyBlock = @import("import_tr_31_key_block.zig").ImportTr31KeyBlock;
const ImportTr34KeyBlock = @import("import_tr_34_key_block.zig").ImportTr34KeyBlock;
const TrustedCertificatePublicKey = @import("trusted_certificate_public_key.zig").TrustedCertificatePublicKey;

/// Parameter information for key material import into Amazon Web Services
/// Payment Cryptography using TR-31 or TR-34 or RSA wrap and unwrap key
/// exchange method.
pub const ImportKeyMaterial = union(enum) {
    /// Parameter information for key material import using AS2805 key cryptogram
    /// format.
    as_2805_key_cryptogram: ?ImportAs2805KeyCryptogram,
    /// Key derivation parameter information for key material import using
    /// asymmetric ECDH key exchange method.
    diffie_hellman_tr_31_key_block: ?ImportDiffieHellmanTr31KeyBlock,
    /// Parameter information for key material import using asymmetric RSA wrap and
    /// unwrap key exchange method.
    key_cryptogram: ?ImportKeyCryptogram,
    /// Parameter information for root public key certificate import.
    root_certificate_public_key: ?RootCertificatePublicKey,
    /// Parameter information for key material import using symmetric TR-31 key
    /// exchange method.
    tr_31_key_block: ?ImportTr31KeyBlock,
    /// Parameter information for key material import using the asymmetric TR-34 key
    /// exchange method.
    tr_34_key_block: ?ImportTr34KeyBlock,
    /// Parameter information for trusted public key certificate import.
    trusted_certificate_public_key: ?TrustedCertificatePublicKey,

    pub const json_field_names = .{
        .as_2805_key_cryptogram = "As2805KeyCryptogram",
        .diffie_hellman_tr_31_key_block = "DiffieHellmanTr31KeyBlock",
        .key_cryptogram = "KeyCryptogram",
        .root_certificate_public_key = "RootCertificatePublicKey",
        .tr_31_key_block = "Tr31KeyBlock",
        .tr_34_key_block = "Tr34KeyBlock",
        .trusted_certificate_public_key = "TrustedCertificatePublicKey",
    };
};
