const FsxOntapConfiguration = @import("fsx_ontap_configuration.zig").FsxOntapConfiguration;
const StorageType = @import("storage_type.zig").StorageType;

/// Storage configuration for replication.
pub const StorageConfiguration = struct {
    /// Storage configuration FSx ONTAP configuration.
    fsx_ontap_configuration: ?FsxOntapConfiguration = null,

    /// Storage configuration storage type.
    storage_type: StorageType,

    pub const json_field_names = .{
        .fsx_ontap_configuration = "fsxOntapConfiguration",
        .storage_type = "storageType",
    };
};
