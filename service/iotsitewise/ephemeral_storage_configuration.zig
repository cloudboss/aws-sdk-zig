const StorageClass = @import("storage_class.zig").StorageClass;

/// Configuration for ephemeral storage attached to the container task.
pub const EphemeralStorageConfiguration = struct {
    /// Storage type that determines I/O performance family and level.
    storage_class: StorageClass,

    /// Storage volume size in GiB.
    storage_size_in_gi_b: i32,

    pub const json_field_names = .{
        .storage_class = "storageClass",
        .storage_size_in_gi_b = "storageSizeInGiB",
    };
};
