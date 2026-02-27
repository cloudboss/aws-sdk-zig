const KeyType = @import("key_type.zig").KeyType;

/// Contains the KMS configuration for a resource.
pub const KmsConfiguration = struct {
    /// The type of KMS key (CustomerManagedKey or ServiceManagedKey).
    key_type: KeyType,

    /// The Amazon Resource Name (ARN) of the KMS key.
    kms_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .key_type = "keyType",
        .kms_key_arn = "kmsKeyArn",
    };
};
