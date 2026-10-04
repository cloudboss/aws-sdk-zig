const ManagedStorageType = @import("managed_storage_type.zig").ManagedStorageType;

/// The managed configuration of a model package group.
pub const ManagedConfiguration = struct {
    /// The storage type of the model package.
    managed_storage_type: ?ManagedStorageType = null,

    pub const json_field_names = .{
        .managed_storage_type = "ManagedStorageType",
    };
};
