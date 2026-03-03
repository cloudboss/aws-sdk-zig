const ApproximateCreationDateTimePrecision = @import("approximate_creation_date_time_precision.zig").ApproximateCreationDateTimePrecision;

/// Enables setting the configuration for Kinesis Streaming.
pub const EnableKinesisStreamingConfiguration = struct {
    /// Toggle for the precision of Kinesis data stream timestamp. The values are
    /// either
    /// `MILLISECOND` or `MICROSECOND`.
    approximate_creation_date_time_precision: ?ApproximateCreationDateTimePrecision = null,

    pub const json_field_names = .{
        .approximate_creation_date_time_precision = "ApproximateCreationDateTimePrecision",
    };
};
