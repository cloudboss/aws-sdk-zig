const EventStreamDestinationStatus = @import("event_stream_destination_status.zig").EventStreamDestinationStatus;

/// Summary information about the Kinesis data stream
pub const DestinationSummary = struct {
    /// The status of enabling the Kinesis stream as a destination for export.
    status: EventStreamDestinationStatus,

    /// The timestamp when the status last changed to `UNHEALHY`.
    unhealthy_since: ?i64,

    /// The StreamARN of the destination to deliver profile events to. For example,
    /// arn:aws:kinesis:region:account-id:stream/stream-name.
    uri: []const u8,

    pub const json_field_names = .{
        .status = "Status",
        .unhealthy_since = "UnhealthySince",
        .uri = "Uri",
    };
};
