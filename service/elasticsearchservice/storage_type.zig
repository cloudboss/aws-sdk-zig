const StorageTypeLimit = @import("storage_type_limit.zig").StorageTypeLimit;

/// StorageTypes represents the list of storage related types and their
/// attributes
/// that are available for given InstanceType.
pub const StorageType = struct {
    storage_sub_type_name: ?[]const u8 = null,

    /// List of limits that are applicable for given storage type.
    storage_type_limits: ?[]const StorageTypeLimit = null,

    storage_type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .storage_sub_type_name = "StorageSubTypeName",
        .storage_type_limits = "StorageTypeLimits",
        .storage_type_name = "StorageTypeName",
    };
};
