const ApproximateCreationDateTimePrecision = @import("approximate_creation_date_time_precision.zig").ApproximateCreationDateTimePrecision;

/// Enables updating the configuration for Kinesis Streaming.
pub const UpdateKinesisStreamingConfiguration = struct {
    /// Enables updating the precision of Kinesis data stream timestamp.
    approximate_creation_date_time_precision: ?ApproximateCreationDateTimePrecision,
};
