/// The configuration for a Lustre MDT (Metadata Target) storage volume.
/// The metadata on Amazon File Cache is managed by a Lustre Metadata Server
/// (MDS) while the actual metadata is persisted on an MDT.
pub const FileCacheLustreMetadataConfiguration = struct {
    /// The storage capacity of the Lustre MDT (Metadata Target) storage
    /// volume in gibibytes (GiB). The only supported value is `2400` GiB.
    storage_capacity: i32,

    pub const json_field_names = .{
        .storage_capacity = "StorageCapacity",
    };
};
