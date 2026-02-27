const KeyEncryptionMechanism = @import("key_encryption_mechanism.zig").KeyEncryptionMechanism;

/// Contains information about the party that receives the response from the API
/// operation.
///
/// This data type is designed to support Amazon Web Services Nitro Enclaves and
/// Amazon Web Services NitroTPM,
/// which lets you create an attested environment in Amazon EC2. For information
/// about the interaction between KMS and Amazon Web Services Nitro Enclaves or
/// Amazon Web Services NitroTPM, see [Cryptographic attestation support in
/// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/cryptographic-attestation.html) in the *Key Management Service Developer Guide*.
pub const RecipientInfo = struct {
    /// The attestation document for an Amazon Web Services Nitro Enclave or a
    /// NitroTPM. This document includes
    /// the enclave's public key.
    attestation_document: ?[]const u8,

    /// The encryption algorithm that KMS should use with the public key for an
    /// Amazon Web Services Nitro
    /// Enclave or NitroTPM to encrypt plaintext values for the response. The only
    /// valid value is
    /// `RSAES_OAEP_SHA_256`.
    key_encryption_algorithm: ?KeyEncryptionMechanism,

    pub const json_field_names = .{
        .attestation_document = "AttestationDocument",
        .key_encryption_algorithm = "KeyEncryptionAlgorithm",
    };
};
