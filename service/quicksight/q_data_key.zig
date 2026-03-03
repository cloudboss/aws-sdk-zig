const QDataKeyType = @import("q_data_key_type.zig").QDataKeyType;

/// A structure that contains information about the `QDataKey`.
pub const QDataKey = struct {
    /// The ARN of the KMS key that is registered to a Quick Sight account for
    /// encryption and decryption use as a `QDataKey`.
    q_data_key_arn: ?[]const u8 = null,

    /// The type of `QDataKey`.
    q_data_key_type: ?QDataKeyType = null,

    pub const json_field_names = .{
        .q_data_key_arn = "QDataKeyArn",
        .q_data_key_type = "QDataKeyType",
    };
};
