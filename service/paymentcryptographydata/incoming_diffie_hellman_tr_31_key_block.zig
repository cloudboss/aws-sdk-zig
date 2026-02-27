const DiffieHellmanDerivationData = @import("diffie_hellman_derivation_data.zig").DiffieHellmanDerivationData;
const SymmetricKeyAlgorithm = @import("symmetric_key_algorithm.zig").SymmetricKeyAlgorithm;
const KeyDerivationFunction = @import("key_derivation_function.zig").KeyDerivationFunction;
const KeyDerivationHashAlgorithm = @import("key_derivation_hash_algorithm.zig").KeyDerivationHashAlgorithm;

/// Parameter information of a TR31KeyBlock wrapped using an ECDH derived key.
pub const IncomingDiffieHellmanTr31KeyBlock = struct {
    /// The `keyArn` of the certificate that signed the client's
    /// `PublicKeyCertificate`.
    certificate_authority_public_key_identifier: []const u8,

    derivation_data: DiffieHellmanDerivationData,

    /// The key algorithm of the derived ECDH key.
    derive_key_algorithm: SymmetricKeyAlgorithm,

    /// The key derivation function to use for deriving a key using ECDH.
    key_derivation_function: KeyDerivationFunction,

    /// The hash type to use for deriving a key using ECDH.
    key_derivation_hash_algorithm: KeyDerivationHashAlgorithm,

    /// The `keyARN` of the asymmetric ECC key pair.
    private_key_identifier: []const u8,

    /// The client's public key certificate in PEM format (base64 encoded) to use
    /// for ECDH key derivation.
    public_key_certificate: []const u8,

    /// The WrappedKeyBlock containing the transaction key wrapped using an ECDH
    /// dervied key.
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
