const ServerSideEncryptionTypes = @import("server_side_encryption_types.zig").ServerSideEncryptionTypes;

/// Encryption configuration of the export job. Includes the encryption type in
/// addition to
/// the AWS KMS key. The KMS key is only necessary if you chose the KMS
/// encryption type.
pub const ExportServerSideEncryption = struct {
    /// The Amazon Resource Name (ARN) of the AWS KMS key you want to use to encrypt
    /// the Amazon
    /// S3 objects. This parameter is required if you choose aws:kms as an
    /// encryption type.
    kms_key_arn: ?[]const u8,

    /// The type of server side encryption used for encrypting the objects in Amazon
    /// S3.
    type: ServerSideEncryptionTypes,

    pub const json_field_names = .{
        .kms_key_arn = "KmsKeyArn",
        .type = "Type",
    };
};
