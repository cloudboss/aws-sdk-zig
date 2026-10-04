const AwsEncryptionKeyConfigurationInput = @import("aws_encryption_key_configuration_input.zig").AwsEncryptionKeyConfigurationInput;

/// The configuration of the encryption key to use for an Autonomous Database.
/// This is a union, so only one of the following members can be specified.
pub const EncryptionKeyConfigurationInput = union(enum) {
    /// The configuration of the Amazon Web Services Key Management Service (KMS)
    /// encryption key to use.
    aws_encryption_key: ?AwsEncryptionKeyConfigurationInput,

    pub const json_field_names = .{
        .aws_encryption_key = "awsEncryptionKey",
    };
};
