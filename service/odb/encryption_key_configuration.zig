const AwsEncryptionKeyConfiguration = @import("aws_encryption_key_configuration.zig").AwsEncryptionKeyConfiguration;
const OciEncryptionKeyConfiguration = @import("oci_encryption_key_configuration.zig").OciEncryptionKeyConfiguration;
const OkvEncryptionKeyConfiguration = @import("okv_encryption_key_configuration.zig").OkvEncryptionKeyConfiguration;

/// The configuration of the encryption key used for an Autonomous Database.
/// This is a union, so only one of the following members can be specified.
pub const EncryptionKeyConfiguration = union(enum) {
    /// The configuration of the Amazon Web Services Key Management Service (KMS)
    /// encryption key.
    aws_encryption_key: ?AwsEncryptionKeyConfiguration,
    /// The configuration of the Oracle Cloud Infrastructure (OCI) Vault encryption
    /// key.
    oci_encryption_key: ?OciEncryptionKeyConfiguration,
    /// The configuration of the Oracle Key Vault (OKV) encryption key.
    okv_encryption_key: ?OkvEncryptionKeyConfiguration,

    pub const json_field_names = .{
        .aws_encryption_key = "awsEncryptionKey",
        .oci_encryption_key = "ociEncryptionKey",
        .okv_encryption_key = "okvEncryptionKey",
    };
};
