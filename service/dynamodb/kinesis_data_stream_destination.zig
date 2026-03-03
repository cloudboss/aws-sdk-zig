const ApproximateCreationDateTimePrecision = @import("approximate_creation_date_time_precision.zig").ApproximateCreationDateTimePrecision;
const DestinationStatus = @import("destination_status.zig").DestinationStatus;

/// Describes a Kinesis data stream destination.
pub const KinesisDataStreamDestination = struct {
    /// The precision of the Kinesis data stream timestamp. The values are either
    /// `MILLISECOND` or `MICROSECOND`.
    approximate_creation_date_time_precision: ?ApproximateCreationDateTimePrecision = null,

    /// The current status of replication.
    destination_status: ?DestinationStatus = null,

    /// The human-readable string that corresponds to the replica status.
    destination_status_description: ?[]const u8 = null,

    /// The ARN for a specific Kinesis data stream.
    stream_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .approximate_creation_date_time_precision = "ApproximateCreationDateTimePrecision",
        .destination_status = "DestinationStatus",
        .destination_status_description = "DestinationStatusDescription",
        .stream_arn = "StreamArn",
    };
};
