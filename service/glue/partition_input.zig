const aws = @import("aws");

const StorageDescriptor = @import("storage_descriptor.zig").StorageDescriptor;

/// The structure used to create and update a partition.
pub const PartitionInput = struct {
    /// The last time at which the partition was accessed.
    last_access_time: ?i64 = null,

    /// The last time at which column statistics were computed for this partition.
    last_analyzed_time: ?i64 = null,

    /// These key-value pairs define partition parameters.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// Provides information about the physical
    /// location where the partition is stored.
    storage_descriptor: ?StorageDescriptor = null,

    /// The values of the partition. Although this parameter is not required by the
    /// SDK, you must specify this parameter for a valid input.
    ///
    /// The values for the keys for the new partition must be passed as an array of
    /// String objects that must be ordered in the same order as the partition keys
    /// appearing in the Amazon S3 prefix. Otherwise Glue will add the values to the
    /// wrong keys.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .last_access_time = "LastAccessTime",
        .last_analyzed_time = "LastAnalyzedTime",
        .parameters = "Parameters",
        .storage_descriptor = "StorageDescriptor",
        .values = "Values",
    };
};
