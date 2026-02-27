const KeyAlgorithm = @import("key_algorithm.zig").KeyAlgorithm;
const KeyClass = @import("key_class.zig").KeyClass;
const KeyModesOfUse = @import("key_modes_of_use.zig").KeyModesOfUse;
const KeyUsage = @import("key_usage.zig").KeyUsage;

/// The role of the key, the algorithm it supports, and the cryptographic
/// operations allowed with the key. This data is immutable after the key is
/// created.
pub const KeyAttributes = struct {
    /// The key algorithm to be use during creation of an Amazon Web Services
    /// Payment Cryptography key.
    ///
    /// For symmetric keys, Amazon Web Services Payment Cryptography supports `AES`
    /// and `TDES` algorithms. For asymmetric keys, Amazon Web Services Payment
    /// Cryptography supports `RSA` and `ECC_NIST` algorithms.
    key_algorithm: KeyAlgorithm,

    /// The type of Amazon Web Services Payment Cryptography key to create, which
    /// determines the classiﬁcation of the cryptographic method and whether Amazon
    /// Web Services Payment Cryptography key contains a symmetric key or an
    /// asymmetric key pair.
    key_class: KeyClass,

    /// The list of cryptographic operations that you can perform using the key.
    key_modes_of_use: KeyModesOfUse,

    /// The cryptographic usage of an Amazon Web Services Payment Cryptography key
    /// as deﬁned in section A.5.2 of the TR-31 spec.
    key_usage: KeyUsage,

    pub const json_field_names = .{
        .key_algorithm = "KeyAlgorithm",
        .key_class = "KeyClass",
        .key_modes_of_use = "KeyModesOfUse",
        .key_usage = "KeyUsage",
    };
};
