const ApproximateCreationDateTimePrecision = @import("approximate_creation_date_time_precision.zig").ApproximateCreationDateTimePrecision;
const DestinationStatus = @import("destination_status.zig").DestinationStatus;

/// Describes a Kinesis data stream destination.
pub const KinesisDataStreamDestination = struct {
    /// The precision of the Kinesis data stream timestamp. The values are either
    /// `MILLISECOND` or `MICROSECOND`.
    approximate_creation_date_time_precision: ?ApproximateCreationDateTimePrecision,

    /// The current status of replication.
    destination_status: ?DestinationStatus,

    /// The human-readable string that corresponds to the replica status.
    destination_status_description: ?[]const u8,

    /// The ARN for a specific Kinesis data stream.
    stream_arn: ?[]const u8,
};
