const JobEventType = @import("job_event_type.zig").JobEventType;

/// Details about the type and time events that occurred related to the Amazon
/// Braket hybrid job.
pub const JobEventDetails = struct {
    /// The type of event that occurred related to the Amazon Braket hybrid job.
    event_type: ?JobEventType = null,

    /// A message describing the event that occurred related to the Amazon Braket
    /// hybrid job.
    message: ?[]const u8 = null,

    /// The time of the event that occurred related to the Amazon Braket hybrid job.
    time_of_event: ?i64 = null,

    pub const json_field_names = .{
        .event_type = "eventType",
        .message = "message",
        .time_of_event = "timeOfEvent",
    };
};
