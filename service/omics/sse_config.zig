const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// Server-side encryption (SSE) settings for a store.
pub const SseConfig = struct {
    /// An encryption key ARN.
    key_arn: ?[]const u8,

    /// The encryption type.
    type: EncryptionType,

    pub const json_field_names = .{
        .key_arn = "keyArn",
        .type = "type",
    };
};
