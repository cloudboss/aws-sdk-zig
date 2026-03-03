/// The metadata needed to successfully rotate a managed external secret. A list
/// of key
/// value pairs in JSON format specified by the partner. For more information,
/// see [Managed
/// external secret
/// partners](https://docs.aws.amazon.com/secretsmanager/latest/userguide/mes-partners.html).
pub const ExternalSecretRotationMetadataItem = struct {
    /// The key that identifies the item.
    key: ?[]const u8 = null,

    /// The value of the specified item.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
