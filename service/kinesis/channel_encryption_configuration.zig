const ChannelEncryptionType = @import("channel_encryption_type.zig").ChannelEncryptionType;

/// Specifies the Amazon Web Services KMS key that Amazon Kinesis Data Streams
/// uses to encrypt data delivered to the channel's destination.
pub const ChannelEncryptionConfiguration = struct {
    /// The encryption type. The only valid value is `KMS`.
    encryption_type: ChannelEncryptionType,

    /// The identifier of the customer managed Amazon Web Services KMS key. You
    /// cannot use the Amazon Kinesis Data Streams service key (`aws/kinesis`).
    key_id: []const u8,

    pub const json_field_names = .{
        .encryption_type = "EncryptionType",
        .key_id = "KeyId",
    };
};
