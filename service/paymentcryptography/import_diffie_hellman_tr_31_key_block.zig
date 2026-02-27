const DiffieHellmanDerivationData = @import("diffie_hellman_derivation_data.zig").DiffieHellmanDerivationData;
const SymmetricKeyAlgorithm = @import("symmetric_key_algorithm.zig").SymmetricKeyAlgorithm;
const KeyDerivationFunction = @import("key_derivation_function.zig").KeyDerivationFunction;
const KeyDerivationHashAlgorithm = @import("key_derivation_hash_algorithm.zig").KeyDerivationHashAlgorithm;

/// Key derivation parameter information for key material import using
/// asymmetric ECDH key exchange method.
pub const ImportDiffieHellmanTr31KeyBlock = struct {
    /// The `keyARN` of the CA that signed the `PublicKeyCertificate` for the
    /// client's receiving ECC key pair.
    certificate_authority_public_key_identifier: []const u8,

    /// The shared information used when deriving a key using ECDH.
    derivation_data: DiffieHellmanDerivationData,

    /// The key algorithm of the shared derived ECDH key.
    derive_key_algorithm: SymmetricKeyAlgorithm,

    /// The key derivation function to use when deriving a key using ECDH.
    key_derivation_function: KeyDerivationFunction,

    /// The hash type to use when deriving a key using ECDH.
    key_derivation_hash_algorithm: KeyDerivationHashAlgorithm,

    /// The `keyARN` of the asymmetric ECC key created within Amazon Web Services
    /// Payment Cryptography.
    private_key_identifier: []const u8,

    /// The public key certificate of the client's receiving ECC key pair, in PEM
    /// format (base64 encoded), to use for ECDH key derivation.
    public_key_certificate: []const u8,

    /// The ECDH wrapped key block to import.
    wrapped_key_block: []const u8,

    pub const json_field_names = .{
        .certificate_authority_public_key_identifier = "CertificateAuthorityPublicKeyIdentifier",
        .derivation_data = "DerivationData",
        .derive_key_algorithm = "DeriveKeyAlgorithm",
        .key_derivation_function = "KeyDerivationFunction",
        .key_derivation_hash_algorithm = "KeyDerivationHashAlgorithm",
        .private_key_identifier = "PrivateKeyIdentifier",
        .public_key_certificate = "PublicKeyCertificate",
        .wrapped_key_block = "WrappedKeyBlock",
    };
};
