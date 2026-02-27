const StorageMaximumSize = @import("storage_maximum_size.zig").StorageMaximumSize;
const StorageMinimumTimeToLive = @import("storage_minimum_time_to_live.zig").StorageMinimumTimeToLive;

/// Size, time, and location options for the data partition.
pub const DataPartitionStorageOptions = struct {
    /// The maximum storage size of the data stored in the data partition.
    ///
    /// Newer data overwrites older data when the partition reaches the maximum
    /// size.
    maximum_size: StorageMaximumSize,

    /// The amount of time that data in this partition will be kept on disk.
    ///
    /// * After the designated amount of time passes, the data can be removed, but
    ///   it's
    /// not guaranteed to be removed.
    ///
    /// * Before the time expires, data in this partition can still be deleted if
    ///   the
    /// partition reaches its configured maximum size.
    ///
    /// * Newer data will overwrite older data when the partition reaches the
    ///   maximum
    /// size.
    minimum_time_to_live: StorageMinimumTimeToLive,

    /// The folder name for the data partition under the campaign storage folder.
    storage_location: []const u8,

    pub const json_field_names = .{
        .maximum_size = "maximumSize",
        .minimum_time_to_live = "minimumTimeToLive",
        .storage_location = "storageLocation",
    };
};
