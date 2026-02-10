const DestinationFileFormat = @import("destination_file_format.zig").DestinationFileFormat;

/// Describes the destination options for a flow log.
pub const DestinationOptionsResponse = struct {
    /// The format for the flow log.
    file_format: ?DestinationFileFormat,

    /// Indicates whether to use Hive-compatible prefixes for flow logs stored in
    /// Amazon S3.
    hive_compatible_partitions: ?bool,

    /// Indicates whether to partition the flow log per hour.
    per_hour_partition: ?bool,
};
