const StorageRuleType = @import("storage_rule_type.zig").StorageRuleType;

/// Describes the storage for a user.
pub const UserStorageMetadata = struct {
    /// The storage for a user.
    storage_rule: ?StorageRuleType,

    /// The amount of storage used, in bytes.
    storage_utilized_in_bytes: ?i64,

    pub const json_field_names = .{
        .storage_rule = "StorageRule",
        .storage_utilized_in_bytes = "StorageUtilizedInBytes",
    };
};
