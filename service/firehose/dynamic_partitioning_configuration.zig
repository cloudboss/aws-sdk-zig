const RetryOptions = @import("retry_options.zig").RetryOptions;

/// The configuration of the dynamic partitioning mechanism that creates smaller
/// data sets
/// from the streaming data by partitioning it based on partition keys.
/// Currently, dynamic
/// partitioning is only supported for Amazon S3 destinations.
pub const DynamicPartitioningConfiguration = struct {
    /// Specifies that the dynamic partitioning is enabled for this Firehose stream.
    enabled: ?bool = null,

    /// The retry behavior in case Firehose is unable to deliver data to an Amazon
    /// S3 prefix.
    retry_options: ?RetryOptions = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .retry_options = "RetryOptions",
    };
};
