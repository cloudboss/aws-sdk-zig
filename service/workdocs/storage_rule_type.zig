const StorageType = @import("storage_type.zig").StorageType;

/// Describes the storage for a user.
pub const StorageRuleType = struct {
    /// The amount of storage allocated, in bytes.
    storage_allocated_in_bytes: ?i64,

    /// The type of storage.
    storage_type: ?StorageType,

    pub const json_field_names = .{
        .storage_allocated_in_bytes = "StorageAllocatedInBytes",
        .storage_type = "StorageType",
    };
};
