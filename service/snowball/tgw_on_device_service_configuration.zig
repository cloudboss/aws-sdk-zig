const StorageUnit = @import("storage_unit.zig").StorageUnit;

/// An object that represents the metadata and configuration settings for the
/// Storage Gateway
/// service Tape Gateway type on an Amazon Web Services Snow Family device.
pub const TGWOnDeviceServiceConfiguration = struct {
    /// The maximum number of virtual tapes to store on one Snow Family device. Due
    /// to physical
    /// resource limitations, this value must be set to 80 for Snowball Edge.
    storage_limit: i32 = 0,

    /// The scale unit of the virtual tapes on the device.
    storage_unit: ?StorageUnit = null,

    pub const json_field_names = .{
        .storage_limit = "StorageLimit",
        .storage_unit = "StorageUnit",
    };
};
