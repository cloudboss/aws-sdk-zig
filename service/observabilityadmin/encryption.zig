const SSEAlgorithm = @import("sse_algorithm.zig").SSEAlgorithm;

/// Defines the encryption configuration for S3 Table integrations, including
/// the encryption algorithm and KMS key settings.
pub const Encryption = struct {
    /// The Amazon Resource Name (ARN) of the KMS key used for encryption when using
    /// customer-managed keys.
    kms_key_arn: ?[]const u8,

    /// The server-side encryption algorithm used for encrypting data in the S3
    /// Table integration.
    sse_algorithm: SSEAlgorithm,

    pub const json_field_names = .{
        .kms_key_arn = "KmsKeyArn",
        .sse_algorithm = "SseAlgorithm",
    };
};
