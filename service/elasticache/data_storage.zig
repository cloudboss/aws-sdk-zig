const DataStorageUnit = @import("data_storage_unit.zig").DataStorageUnit;

/// The data storage limit.
pub const DataStorage = struct {
    /// The upper limit for data storage the cache is set to use.
    maximum: ?i32,

    /// The lower limit for data storage the cache is set to use.
    minimum: ?i32,

    /// The unit that the storage is measured in, in GB.
    unit: DataStorageUnit,
};
