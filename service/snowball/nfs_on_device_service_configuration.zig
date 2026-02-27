const StorageUnit = @import("storage_unit.zig").StorageUnit;

/// An object that represents the metadata and configuration settings for the
/// NFS (Network
/// File System) service on an Amazon Web Services Snow Family device.
pub const NFSOnDeviceServiceConfiguration = struct {
    /// The maximum NFS storage for one Snow Family device.
    storage_limit: i32 = 0,

    /// The scale unit of the NFS storage on the device.
    ///
    /// Valid values: TB.
    storage_unit: ?StorageUnit,

    pub const json_field_names = .{
        .storage_limit = "StorageLimit",
        .storage_unit = "StorageUnit",
    };
};
