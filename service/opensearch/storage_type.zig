const StorageTypeLimit = @import("storage_type_limit.zig").StorageTypeLimit;

/// A list of storage types for an Amazon OpenSearch Service domain that are
/// available for
/// a given intance type.
pub const StorageType = struct {
    /// The storage sub-type, such as `gp3` or `io1`.
    storage_sub_type_name: ?[]const u8 = null,

    /// Limits that are applicable for the given storage type.
    storage_type_limits: ?[]const StorageTypeLimit = null,

    /// The name of the storage type.
    storage_type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .storage_sub_type_name = "StorageSubTypeName",
        .storage_type_limits = "StorageTypeLimits",
        .storage_type_name = "StorageTypeName",
    };
};
