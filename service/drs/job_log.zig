const JobLogEvent = @import("job_log_event.zig").JobLogEvent;
const JobLogEventData = @import("job_log_event_data.zig").JobLogEventData;

/// A log outputted by a Job.
pub const JobLog = struct {
    /// The event represents the type of a log.
    event: ?JobLogEvent = null,

    /// Metadata associated with a Job log.
    event_data: ?JobLogEventData = null,

    /// The date and time the log was taken.
    log_date_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .event = "event",
        .event_data = "eventData",
        .log_date_time = "logDateTime",
    };
};
