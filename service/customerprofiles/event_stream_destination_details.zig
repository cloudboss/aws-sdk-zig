const EventStreamDestinationStatus = @import("event_stream_destination_status.zig").EventStreamDestinationStatus;

/// Details of the destination being used for the EventStream.
pub const EventStreamDestinationDetails = struct {
    /// The human-readable string that corresponds to the error or success while
    /// enabling the
    /// streaming destination.
    message: ?[]const u8,

    /// The status of enabling the Kinesis stream as a destination for export.
    status: EventStreamDestinationStatus,

    /// The timestamp when the status last changed to `UNHEALHY`.
    unhealthy_since: ?i64,

    /// The StreamARN of the destination to deliver profile events to. For example,
    /// arn:aws:kinesis:region:account-id:stream/stream-name.
    uri: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .status = "Status",
        .unhealthy_since = "UnhealthySince",
        .uri = "Uri",
    };
};
