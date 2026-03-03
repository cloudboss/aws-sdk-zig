const MagneticStoreRejectedDataLocation = @import("magnetic_store_rejected_data_location.zig").MagneticStoreRejectedDataLocation;

/// The set of properties on a table for configuring magnetic store writes.
pub const MagneticStoreWriteProperties = struct {
    /// A flag to enable magnetic store writes.
    enable_magnetic_store_writes: bool,

    /// The location to write error reports for records rejected asynchronously
    /// during magnetic
    /// store writes.
    magnetic_store_rejected_data_location: ?MagneticStoreRejectedDataLocation = null,

    pub const json_field_names = .{
        .enable_magnetic_store_writes = "EnableMagneticStoreWrites",
        .magnetic_store_rejected_data_location = "MagneticStoreRejectedDataLocation",
    };
};
