const DestinationFileFormat = @import("destination_file_format.zig").DestinationFileFormat;

/// Describes the destination options for a flow log.
pub const DestinationOptionsRequest = struct {
    /// The format for the flow log. The default is `plain-text`.
    file_format: ?DestinationFileFormat = null,

    /// Indicates whether to use Hive-compatible prefixes for flow logs stored in
    /// Amazon S3.
    /// The default is `false`.
    hive_compatible_partitions: ?bool = null,

    /// Indicates whether to partition the flow log per hour. This reduces the cost
    /// and response
    /// time for queries. The default is `false`.
    per_hour_partition: ?bool = null,
};
