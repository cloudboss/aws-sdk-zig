const SymmetricKeyAlgorithm = @import("symmetric_key_algorithm.zig").SymmetricKeyAlgorithm;
const KeyDerivationFunction = @import("key_derivation_function.zig").KeyDerivationFunction;
const KeyDerivationHashAlgorithm = @import("key_derivation_hash_algorithm.zig").KeyDerivationHashAlgorithm;

/// Parameters required to establish ECDH based key exchange.
pub const EcdhDerivationAttributes = struct {
    /// The `keyArn` of the certificate that signed the client's
    /// `PublicKeyCertificate`.
    certificate_authority_public_key_identifier: []const u8,

    /// The key algorithm of the derived ECDH key.
    key_algorithm: SymmetricKeyAlgorithm,

    /// The key derivation function to use for deriving a key using ECDH.
    key_derivation_function: KeyDerivationFunction,

    /// The hash type to use for deriving a key using ECDH.
    key_derivation_hash_algorithm: KeyDerivationHashAlgorithm,

    /// The client's public key certificate in PEM format (base64 encoded) to use
    /// for ECDH key derivation.
    public_key_certificate: []const u8,

    /// A byte string containing information that binds the ECDH derived key to the
    /// two parties involved or to the context of the key.
    ///
    /// It may include details like identities of the two parties deriving the key,
    /// context of the operation, session IDs, and optionally a nonce. It must not
    /// contain zero bytes, and re-using shared information for multiple ECDH key
    /// derivations is not recommended.
    shared_information: []const u8,

    pub const json_field_names = .{
        .certificate_authority_public_key_identifier = "CertificateAuthorityPublicKeyIdentifier",
        .key_algorithm = "KeyAlgorithm",
        .key_derivation_function = "KeyDerivationFunction",
        .key_derivation_hash_algorithm = "KeyDerivationHashAlgorithm",
        .public_key_certificate = "PublicKeyCertificate",
        .shared_information = "SharedInformation",
    };
};
